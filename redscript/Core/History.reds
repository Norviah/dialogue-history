module DialogueHistory.Core

import DialogueHistory.Globals.StrToProperCase
import DialogueHistory.Structs.{Area, DialogueLine, TimeFormat, TimeStamp}


public class History extends ScriptableSystem {
  private persistent let m_conversations: array<ref<Conversation>>;

  private let m_config: ref<Config>;

  private let m_timeSystem: ref<TimeSystem>;

  private let m_preventionSystem: ref<PreventionSystem>;

  private let m_subtitleManager: ref<SubtitleManager>;

  public func OnAttach() -> Void {
    this.m_config = Config.GetInstance();
    this.m_timeSystem = GameInstance.GetTimeSystem(this.GetGameInstance());
    this.m_preventionSystem = GameInstance.GetScriptableSystemsContainer(this.GetGameInstance()).Get(n"PreventionSystem") as PreventionSystem;
    this.m_subtitleManager = SubtitleManager.GetInstance();
  }

  public func OnDetach() -> Void {
    this.m_config = null;
    this.m_timeSystem = null;
    this.m_preventionSystem = null;
    this.m_subtitleManager = null;
  }

  public func GetConversations() -> [ref<Conversation>] {
    return this.m_conversations;
  }

  public func GetSize() -> Int32 {
    return ArraySize(this.m_conversations);
  }

  public func IsEmpty() -> Bool {
    return Equals(this.GetSize(), 0);
  }

  protected func AddConversation(conversation: ref<Conversation>) -> Void {
    ArrayPush(this.m_conversations, conversation);
  }

  public func RemoveConversation(conversation: wref<Conversation>) -> Void {
    ArrayRemove(this.m_conversations, conversation);
  }

  protected func CreateConversation(resourcePath: String) -> ref<Conversation> {
    if this.m_config.limitConversation {
      this.TrimConversations();
    }

    let conversation: ref<Conversation> = Conversation.Initialize(resourcePath);
    this.AddConversation(conversation);

    return conversation;
  }

  protected func TrimConversations() -> Void {
    let maxLength: Int32 = this.m_config.conversationLimit;

    for conversation in this.m_conversations {
      if !conversation.IsSaved() {
        let length: Int32 = this.GetSize();

        if length >= maxLength {
          this.RemoveConversation(conversation);
        } else {
          return;
        }
      }
    }
  }

  protected func FindConversationForResourcePath(path: String) -> ref<Conversation> {
    for conversation in this.m_conversations {
      if conversation.IsFromResourcePath(path) {
        return conversation;
      }
    }

    return null;
  }

  protected func GetConversation(resourcePath: String) -> ref<Conversation> {
    let conversation: ref<Conversation> = this.FindConversationForResourcePath(resourcePath);

    if IsDefined(conversation) {
      return conversation;
    } else {
      return this.CreateConversation(resourcePath);
    }
  }

  protected func ReIndexConversation(conversation: ref<Conversation>) -> Void {
    if NotEquals(ArrayLast(this.m_conversations), conversation) {
      this.RemoveConversation(conversation);
      this.AddConversation(conversation);
    }
  }

  public func AddLine(rawLine: scnDialogLineData) -> Void {
    if rawLine.isPersistent {
      return;
    }

    let line: DialogueLine = this.ParseLineData(rawLine);
    let resourceSubtitleResource: SubtitleResource = this.m_subtitleManager.FindResource(rawLine);
    let conversation: ref<Conversation> = this.GetConversation(resourceSubtitleResource.m_path);
    conversation.AddLine(line);

    this.ReIndexConversation(conversation);
  }

  protected func ParseLineData(lineData: scnDialogLineData) -> DialogueLine {
    let displayData: scnDialogDisplayString = scnDialogLineData.GetDisplayText(lineData);
    let text: String;

    if NotEquals(displayData.language, scnDialogLineLanguage.Origin) && NotEquals(displayData.translation, "")  {
      text = displayData.translation;
    } else if scnDialogLineData.HasMothertongueTag(lineData) {
      text = s"\(displayData.preTranslatedText)\(displayData.text)\(displayData.postTranslatedText)";
    } else {
      text = lineData.text;
    }

    let rawSpeakerName: String;

    let puppet: wref<NPCPuppet> = lineData.speaker as NPCPuppet;
    let affiliation: wref<Affiliation_Record> = TweakDBInterface.GetCharacterRecord(puppet.GetRecordID()).Affiliation();

    if IsDefined(puppet) && IsDefined(affiliation) && (Equals(lineData.speakerName, "NC Resident")) {
      rawSpeakerName = Equals(affiliation.Type(), gamedataAffiliation.Unaffiliated) ? lineData.speakerName : ToString(affiliation.EnumName());
    } else if Equals(lineData.speakerName, "") {
      rawSpeakerName = GetLocalizedTextByKey(n"DialogueHistory-UI-UnknownSpeaker");
    } else {
      rawSpeakerName = lineData.speakerName;
    }

    let speakerName: String = StrContains(rawSpeakerName, "_") ? StrToProperCase(rawSpeakerName) : rawSpeakerName;
    let timestamp: TimeStamp = TimeStamp.Initialize(this.m_timeSystem.GetGameTime());
    let area: Area = Area.Initialize(this.m_preventionSystem.GetCurrentDistrict().GetDistrictRecord());

    return DialogueLine(StringToName(speakerName), StringToName(text), lineData.type, timestamp, area);
  }

  public final static func GetInstance(gameInstance: GameInstance) -> ref<History> {
    return GameInstance.GetScriptableSystemsContainer(gameInstance).Get(n"DialogueHistory.Core.History") as History;
  }
}