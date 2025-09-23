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
  /// A reference to all loaded subtitle entries.
  public let m_resources: [SubtitleResource];

  /// Called during script initialization on game startup.
  private cb func OnLoad() -> Void {
    GameInstance.GetCallbackSystem().RegisterCallback(n"Resource/Ready", this, n"OnJsonResourceReady").AddTarget(ResourceTarget.Type(n"jsonResource"));
  }

  private final func InternalFindResource(line: scnDialogLineData) -> SubtitleResource {
    for resource in this.m_resources {
      if resource.Has(line) {
        return resource;
      }
    }

    return SubtitleResource("", []);
  }

  /// Moves the given resource entry to the beginning of the array.
  ///
  /// When finding which resource a line comes from, we use a line's exact text.
  /// However some lines may have the exact same lines as other resources, so
  /// whenever we find a resource, we'll move it to the beginning of the array
  /// so it's more likely we'll use the same resource for future conversations.
  private final func PrependResource(resource: SubtitleResource) -> Void {
    ArrayRemove(this.m_resources, resource);
    ArrayInsert(this.m_resources, 0, resource);
  }

  /// Finds the respective resource for the given line.
  public func FindResource(line: scnDialogLineData) -> SubtitleResource {
    let resource: SubtitleResource = this.InternalFindResource(line);

    if SubtitleResource.IsValid(resource) {
      this.PrependResource(resource);
    }

    return resource;
  }

  private cb func OnJsonResourceReady(event: ref<ResourceEvent>) -> Void {
    let resource: ref<JsonResource> = event.GetResource() as JsonResource;
    let entry: ref<localizationPersistenceSubtitleEntries> = resource.root as localizationPersistenceSubtitleEntries;

    if IsDefined(entry) {
      ArrayPush(this.m_resources, SubtitleResource(resource.path.ToString(), entry.entries));
    }
  }

  public final static func GetInstance() -> ref<SubtitleManager> {
    return GameInstance.GetScriptableServiceContainer().GetService(n"DialogueHistory.Core.SubtitleManager") as SubtitleManager;
  }
}