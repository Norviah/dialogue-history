module DialogueHistory.Core


/// References a collection of subtitles within the game files.
///
/// In the game files, subtitles are stored in Json files under folders for
/// quests and NPCs. Each folder, usually for quests, may have multiple files for
/// a respective phase/context.
///
/// As the game's systems doesn't expose a way to know which file a line comes
/// from, this manager will store references to all loaded subtitle files for
/// future reference when saving dialogue lines.
///
/// As an example, here's how the game stores subtitles for the heist quest:
/// - q0005
///   - q0005_00_quest_setup.json
///   - q0005_01_plan.json
///   - q0005_01a_slice_of_afterlife.json
///   - q0005_02_cab_ride.json
///   - q0005_03_entrence.json
///   - q0005_04_spiderbot.json
///   - q0005_05_hotel_fluff.json
///   - q0005_06_undercover.json
///   - q0005_07_vip_apartment.json
///   - q0005_09_attack.json
///   - q0005_10_taking_the_chip.json
///   - q0005_14_after_escape.json
///   - q0005_15_no_tell_motel.json
public class SubtitleManager extends ScriptableService {
  public let m_subtitleEntries: ref<inkHashMap>;

  public let m_pool: ref<inkHashMap>;

  private let m_scenes: [String];

  protected let m_isPlayerFemale: Bool;

  private cb func OnLoad() -> Void {
    this.m_subtitleEntries = new inkHashMap();
    this.m_pool = new inkHashMap();
    this.m_scenes = [];

    GameInstance.GetCallbackSystem().RegisterCallback(n"Resource/Ready", this, n"OnJsonResourceReady").AddTarget(ResourceTarget.Type(n"jsonResource"));
    GameInstance.GetCallbackSystem().RegisterCallback(n"Resource/Ready", this, n"OnSceneResourceReady").AddTarget(ResourceTarget.Type(n"scnSceneResource"));
    GameInstance.GetCallbackSystem().RegisterCallback(n"Session/Ready", this, n"OnSessionReady");
  }

  private cb func OnSessionReady(event: ref<GameSessionEvent>) -> Void {
    if !event.IsPreGame() {
      this.m_pool = new inkHashMap();
    }
  }

  protected cb func OnJsonResourceReady(event: ref<ResourceEvent>) -> Void {
    let resource: ref<JsonResource> = event.GetResource() as JsonResource;
    let entry: ref<localizationPersistenceSubtitleEntries> = resource.root as localizationPersistenceSubtitleEntries;

    if IsDefined(entry) {
      let resourcePath: String = resource.path.ToString();

      for line in entry.entries {
        this.m_subtitleEntries.Insert(SubtitleManager.Hash(line.stringId), SubtitleEntry.Initialize(resourcePath, line));
      }
    }
  }

  protected cb func OnSceneResourceReady(event: ref<ResourceEvent>) -> Void {
    let resource: ref<scnSceneResource> = event.GetResource() as scnSceneResource;
    let resourcePath: String = resource.path.ToString();

    if !IsDefined(resource) || ArrayContains(this.m_scenes, resourcePath) {
      return;
    }

    if ArraySize(resource.screenplayStore.lines) > 0 {
      let screenPlayStoreLines: ref<inkHashMap> = new inkHashMap();

      for line in resource.screenplayStore.lines {
        screenPlayStoreLines.Insert(Cast<Uint64>(line.itemId.id), ScreenPlayStoreLineWrapper.Create(line));
      }

      for node in resource.sceneGraph.graph {
        let sectionNode = node as scnSectionNode;

        if IsDefined(sectionNode) {
          for event in sectionNode.events {
            let scnDialogLineEvent = event as scnDialogLineEvent;

            if IsDefined(scnDialogLineEvent) {
              let screenPlayLine = screenPlayStoreLines.Get(Cast<Uint64>(scnDialogLineEvent.screenplayLineId.id)) as ScreenPlayStoreLineWrapper;
              let entry = this.m_subtitleEntries.Get(SubtitleManager.Hash(screenPlayLine.m_line.locstringId.ruid)) as SubtitleEntry;

              if IsDefined(screenPlayLine) && IsDefined(entry) {
                entry.SetType(scnDialogLineEvent.visualStyle, scnDialogLineEvent.voParams.isHolocallSpeaker);
                entry.m_speaker = resource.actors[Cast<Int32>(screenPlayLine.m_line.speaker.id)].actorName;
              }
            }
          }
        }
      }
    }

    ArrayPush(this.m_scenes, resourcePath);
  }

  public func IsPlayerFemale() -> Bool {
    let player: ref<PlayerPuppet> = GameInstance.GetPlayerSystem(GetGameInstance()).GetLocalPlayerControlledGameObject() as PlayerPuppet;

    if !IsDefined(player) {
      return true;
    } else {
      return Equals(player.GetResolvedGenderName(), n"Female");
    }
  }

  public func GetEntryText(entry: ref<SubtitleEntry>) -> String {
    if !IsStringValid(entry.m_maleVariant) || this.IsPlayerFemale() {
      return entry.m_femaleVariant;
    } else {
      return entry.m_maleVariant;
    }
  }

  public func AddEntryToPool(text: String, entry: ref<SubtitleEntry>) -> Void {
    this.m_pool.Insert(SubtitleManager.Hash(text), entry);
  }

  public func GetEntryFromPool(text: String) -> ref<SubtitleEntry> {
    return this.m_pool.Get(SubtitleManager.Hash(text)) as SubtitleEntry;
  }

  public func RemoveEntryFromPool(id: String) -> Void {
    this.m_pool.Remove(SubtitleManager.Hash(id));
  }

  public func RemoveEntryFromPool(entry: ref<SubtitleEntry>) -> Void {
    this.RemoveEntryFromPool(entry.m_femaleVariant);
  }

  public static func Hash(string: String) -> Uint64 {
    return TDBID.ToNumber(TDBID.Create(string));
  }

  public static func Hash(id: CRUID) -> Uint64 {
    return SubtitleManager.Hash(ToString(id));
  }

  public final static func GetInstance() -> ref<SubtitleManager> {
    return GameInstance.GetScriptableServiceContainer().GetService(n"DialogueHistory.Core.SubtitleManager") as SubtitleManager;
  }
}


class ScreenPlayStoreLineWrapper extends IScriptable {
  public let m_line: scnscreenplayDialogLine;

  public static final func Create(line: scnscreenplayDialogLine) -> ref<ScreenPlayStoreLineWrapper> {
    let ref: ref<ScreenPlayStoreLineWrapper> = new ScreenPlayStoreLineWrapper();
    ref.m_line = line;

    return ref;
  }
}