module DialogueHistory.UI

import DialogueHistory.Core.{Conversation, Config}
import DialogueHistory.Structs.{Area, ColorToName, DialogueLine, TimeFormat, TimeStamp}
import DialogueHistory.Globals.ArrayJoin


public class ConversationListItemController extends inkVirtualCompoundItemController {
  private let m_labelRef: inkTextRef;

  private let m_descriptionRef: inkTextRef;

  private let m_frameRef: inkImageRef;

  private let m_interactionBackgroundRef: inkImageRef;

  private let m_data: wref<ConversationListItemData>;

  private let m_menuController: wref<DialogueHistoryMenuController>;

  private let m_conversation: wref<Conversation>;

  private let m_isItemHovered: Bool;

  private let m_isItemToggled: Bool;

  private let m_config: wref<Config>;

  protected cb func OnInitialize() -> Bool {
    this.RegisterToCallback(n"OnToggledOn", this, n"OnToggledOn");
    this.RegisterToCallback(n"OnToggledOff", this, n"OnToggledOff");
    this.RegisterToCallback(n"OnSelected", this, n"OnHoverIn");
    this.RegisterToCallback(n"OnDeselected", this, n"OnHoverOut");
    this.RegisterToCallback(n"OnRelease", this, n"OnRelease");

    this.m_config = Config.GetInstance();

    this.m_labelRef.widget.BindProperty(n"tintColor", ColorToName(this.m_config.titleColor));
    this.m_descriptionRef.widget.BindProperty(n"tintColor", ColorToName(this.m_config.descriptionColor));
  }

  protected cb func OnRelease(event: ref<inkPointerEvent>) -> Bool {
    if event.IsAction(n"upgrade_cyberware") {
      this.QueueEvent(DeleteConversationEvent.Create(this.m_data));
    }

    if event.IsAction(n"UI_smart_frame_remove") {
      this.ToggleSave();
    }
  }

  protected cb func OnDataChanged(value: Variant) -> Bool {
    this.m_data = FromVariant<ref<IScriptable>>(value) as ConversationListItemData;

    this.m_conversation = this.m_data.m_conversation;
    this.m_menuController = this.m_data.m_menuController;

    inkTextRef.SetText(this.m_labelRef, this.m_conversation.GetNames());

    let lastLine = this.m_conversation.GetLastLine();
    let array: [String] = [];

    if this.m_config.showDay {
      ArrayPush(array, s"\(GetLocalizedTextByKey(n"UI-Labels-Day")) \(lastLine.timestamp.day)");
    }

    if this.m_config.showTimestamps {
      ArrayPush(array, TimeStamp.FormatTime(lastLine.timestamp, this.m_config.timeFormat));
    }

    ArrayPush(array, Area.ToString(lastLine.area));

    if this.m_config.showLineType {
      ArrayPush(array, this.TypeStrings());
    }

    inkTextRef.SetText(this.m_descriptionRef, ArrayJoin(array, " •"));

    this.UpdateFrame();
    this.UpdateState();
  }

  public final func TypeStrings() -> String {
    let types: [scnDialogLineType] = this.m_conversation.GetTypes();
    let string: [String] = [];

    for type in types {
      ArrayPush(string, GetLocalizedTextByKey(StringToName(s"DialogueHistory-DialogueLineType-\(type)")));
    }

    return ArrayJoin(string, ",");
  }

  // ---
  // EVENTS
  // ---

  protected cb func OnContactSyncData(evt: ref<MessengerContactSyncBackEvent>) -> Bool {
    this.UpdateState();
  }

  protected cb func OnToggledOn(itemController: wref<inkVirtualCompoundItemController>) -> Bool {
    this.QueueEvent(ConversationSelectedEvent.Create(this.m_conversation));

    this.PlaySound(n"Button", n"OnPress");
    this.m_isItemToggled = true;
  }

  protected cb func OnToggledOff(itemController: wref<inkVirtualCompoundItemController>) -> Bool {
    this.m_isItemToggled = false;
    this.UpdateState();
  }

  protected cb func OnHoverIn(itemController: wref<inkVirtualCompoundItemController>, discreteNav: Bool) -> Bool {
    this.m_isItemHovered = true;
    this.UpdateState();
    if discreteNav {
      this.SetCursorOverWidget(this.GetRootWidget());
    };

    this.QueueEvent(UpdateButtonHintsEvent.Create(this.m_conversation));
  }

  protected cb func OnHoverOut(itemController: wref<inkVirtualCompoundItemController>) -> Bool {
    this.m_isItemHovered = false;
    this.UpdateState();

    this.QueueEvent(ResetButtonHintsEvent.Create());
  }

  protected final func ToggleSave() -> Void {
    this.m_conversation.ToggleSave();
    this.UpdateFrame();

    if this.m_isItemHovered {
      this.QueueEvent(UpdateButtonHintsEvent.Create(this.m_conversation));
    }

    this.QueueEvent(FilterEvent.Create());
  }

  protected final func UpdateFrame() -> Void {
    this.m_interactionBackgroundRef.widget.BindProperty(n"tintColor", ColorToName(this.m_conversation.IsSaved() ? this.m_config.savedConversationBackgroundColor : this.m_config.conversationBackgroundColor));
    this.m_frameRef.widget.BindProperty(n"tintColor", ColorToName(this.m_conversation.IsSaved() ? this.m_config.savedConversationFrameColor : this.m_config.conversationFrameColor));
  }

  private final func UpdateState() -> Void {
    if Equals(this.m_menuController.m_selectedConversation, this.m_conversation) {
      this.GetRootWidget().SetState(n"Active");
    } else if this.m_isItemHovered {
      this.GetRootWidget().SetState(n"Hover");
    } else {
      this.GetRootWidget().SetState(n"Default");
    }
  }
}

