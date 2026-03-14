module DialogueHistory.UI

import Codeware.UI.*
import DialogueHistory.Core.{Conversation, Config}
import DialogueHistory.Globals.ArrayJoin


public class TextPromptController extends inkGameController {
  private let m_title: inkTextRef;

  private let m_message: inkTextRef;

  private let m_buttonConfirm: inkWidgetRef;

  private let m_buttonCancel: inkWidgetRef;

  private let m_root: inkWidgetRef;

  private let m_background: inkWidgetRef;

  private let m_buttonHintsRoot: inkWidgetRef;

  private let m_input: wref<HubTextInput>;

  private let m_buttonHintsController: wref<ButtonHints>;

  private let m_data: ref<TextPromptNotificationData>;

  private let m_isNegativeHovered: Bool;

  private let m_isPositiveHovered: Bool;

  private let m_libraryPath: inkWidgetLibraryReference;

  protected func RegisterCallbacks() -> Void {
    this.RegisterToGlobalInputCallback(n"OnPostOnPress", this, n"OnHandlePressInput");

    inkWidgetRef.RegisterToCallback(this.m_buttonConfirm, n"OnRelease", this, n"OnConfirmClick");
    inkWidgetRef.RegisterToCallback(this.m_buttonCancel, n"OnRelease", this, n"OnCancelClick");
    inkWidgetRef.RegisterToCallback(this.m_buttonConfirm, n"OnHoverOver", this, n"OnPositiveHoverOver");
    inkWidgetRef.RegisterToCallback(this.m_buttonCancel, n"OnHoverOver", this, n"OnNegativeHoverOver");
    inkWidgetRef.RegisterToCallback(this.m_buttonConfirm, n"OnHoverOut", this, n"OnPositiveHoverOut");
    inkWidgetRef.RegisterToCallback(this.m_buttonCancel, n"OnHoverOut", this, n"OnNegativeHoverOut");
  }

  protected cb func OnInitialize() -> Bool {
    this.RegisterCallbacks();

    this.m_data = this.GetRootWidget().GetUserData(n"GenericMessageNotificationData") as TextPromptNotificationData;

    inkTextRef.SetText(this.m_title, this.m_data.title);
    inkTextRef.SetText(this.m_message, this.m_data.message);

    let input: ref<HubTextInput> = HubTextInput.Create();
    input.SetLetterCase(textLetterCase.UpperCase);
    input.SetDefaultText("[Default Title]");
    input.m_fill.SetTexturePart(n"filter1_bg");
    input.m_frame.SetTexturePart(n"filter1_fg");
    input.m_hover.SetTexturePart(n"filter1_fg");
    input.m_focus.SetTexturePart(n"filter1_fg");
    input.m_root.SetSizeRule(inkESizeRule.Stretch);
    input.Reparent(this.m_message.widget.parentWidget as inkCompoundWidget);

    this.m_input = input;

    this.PlayLibraryAnimation(n"vendor_popup_sell_junk_intro");
    this.PlayLibraryAnimation(n"intro");
  }

  protected cb func OnUninitialize() -> Bool {
    this.UnregisterFromGlobalInputCallback(n"OnPostOnPress", this, n"OnHandlePressInput");
  }

  private final func AddButtonHints(actionName: CName, const label: script_ref<String>) -> Void {
    let buttonHint: ref<LabelInputDisplayController> = this.SpawnFromExternal(inkWidgetRef.Get(this.m_buttonHintsRoot), inkWidgetLibraryResource.GetPath(this.m_libraryPath.widgetLibrary), this.m_libraryPath.widgetItem).GetController() as LabelInputDisplayController;
    buttonHint.SetInputActionLabel(actionName, label);
  }

  protected cb func OnHandlePressInput(evt: ref<inkPointerEvent>) -> Bool {
    if evt.IsAction(n"proceed") && !this.m_isNegativeHovered {
      this.Close(GenericMessageNotificationResult.Confirm);
    } else if evt.IsAction(n"cancel") || evt.IsAction(n"proceed") && this.m_isNegativeHovered {
      this.Close(GenericMessageNotificationResult.Cancel);
    };
  }

  protected cb func OnConfirmClick(evt: ref<inkPointerEvent>) -> Bool {
    if evt.IsAction(n"click") {
      this.Close(GenericMessageNotificationResult.Confirm);
    };
  }

  protected cb func OnCancelClick(evt: ref<inkPointerEvent>) -> Bool {
    if evt.IsAction(n"click") {
      this.Close(GenericMessageNotificationResult.Cancel);
    };
  }

  protected cb func OnPositiveHoverOver(evt: ref<inkPointerEvent>) -> Bool {
    this.m_isPositiveHovered = true;
  }

  protected cb func OnNegativeHoverOver(evt: ref<inkPointerEvent>) -> Bool {
    this.m_isNegativeHovered = true;
  }

  protected cb func OnPositiveHoverOut(evt: ref<inkPointerEvent>) -> Bool {
    this.m_isPositiveHovered = false;
  }

  protected cb func OnNegativeHoverOut(evt: ref<inkPointerEvent>) -> Bool {
    this.m_isNegativeHovered = false;
  }

  private final func Close(result: GenericMessageNotificationResult) -> Void {
    let closeData = new TextPromptCloseData();
    closeData.identifier = this.m_data.identifier;
    closeData.result = result;
    closeData.text = this.m_input.GetText();
    closeData.item = this.m_data.item;

    this.PlayLibraryAnimation(n"outro");
    this.m_data.token.TriggerCallback(closeData);
  }

  protected cb func OnCloseAnimationFinished(proxy: ref<inkAnimProxy>) -> Bool {
    return false;
  }

  // private final static func GetBaseData() -> ref<TextPromptNotificationData> {
  //   let data: ref<TextPromptNotificationData> = new TextPromptNotificationData();
  //   data.notificationName = n"base\\gameplay\\gui\\widgets\\notifications\\text_prompt_input.inkwidget";
  //   data.isBlocking = true;
  //   data.useCursor = true;
  //   data.queueName = n"modal_popup";
  //   return data;
  // }

  // public final static func Show(controller: ref<worlduiIGameController>, const title: script_ref<String>, const message: script_ref<String>) -> ref<inkGameNotificationToken> {
  //   let data: ref<TextPromptNotificationData> = GenericMessageNotification.GetBaseData();
  //   data.title = Deref(title);
  //   data.message = Deref(message);
  //   return controller.ShowGameNotification(data);
  // }

  // public final static func Show(controller: ref<worlduiIGameController>, identifier: Int32, const title: script_ref<String>, const message: script_ref<String>) -> ref<inkGameNotificationToken> {
  //   let data: ref<TextPromptNotificationData> = GenericMessageNotification.GetBaseData();
  //   data.title = Deref(title);
  //   data.message = Deref(message);
  //   data.identifier = identifier;
  //   return controller.ShowGameNotification(data);
  // }

  // public final static func Show(controller: ref<worlduiIGameController>, const message: script_ref<String>) -> ref<inkGameNotificationToken> {
  //   let data: ref<TextPromptNotificationData> = GenericMessageNotification.GetBaseData();
  //   data.message = Deref(message);
  //   return controller.ShowGameNotification(data);
  // }

  // public final static func Show(controller: ref<worlduiIGameController>, identifier: Int32, const message: script_ref<String>) -> ref<inkGameNotificationToken> {
  //   let data: ref<TextPromptNotificationData> = GenericMessageNotification.GetBaseData();
  //   data.message = Deref(message);
  //   data.identifier = identifier;
  //   return controller.ShowGameNotification(data);
  // }

  public final static func Show(controller: ref<worlduiIGameController>, const title: script_ref<String>, const message: script_ref<String>, item: ref<ConversationListItemController>) -> ref<inkGameNotificationToken> {
    let data: ref<TextPromptNotificationData> = new TextPromptNotificationData();
    data.notificationName = n"base\\gameplay\\gui\\widgets\\notifications\\text_prompt_input.inkwidget";
    data.isBlocking = true;
    data.useCursor = true;
    data.queueName = n"modal_popup";
    data.item = item;
    data.type = GenericMessageNotificationType.ConfirmCancel;
    data.title = Deref(title);
    data.message = Deref(message);

    return controller.ShowGameNotification(data);
  }

  // public final static func Show(controller: ref<worlduiIGameController>, identifier: Int32, const title: script_ref<String>, const message: script_ref<String>, type: GenericMessageNotificationType) -> ref<inkGameNotificationToken> {
  //   let data: ref<TextPromptNotificationData> = GenericMessageNotification.GetBaseData();
  //   data.title = Deref(title);
  //   data.message = Deref(message);
  //   data.identifier = identifier;
  //   data.type = type;
  //   return controller.ShowGameNotification(data);
  // }

  // public final static func Show(controller: ref<worlduiIGameController>, const message: script_ref<String>, type: GenericMessageNotificationType) -> ref<inkGameNotificationToken> {
  //   let data: ref<TextPromptNotificationData> = GenericMessageNotification.GetBaseData();
  //   data.message = Deref(message);
  //   data.type = type;
  //   return controller.ShowGameNotification(data);
  // }

  // public final static func Show(controller: ref<worlduiIGameController>, identifier: Int32, const message: script_ref<String>, type: GenericMessageNotificationType) -> ref<inkGameNotificationToken> {
  //   let data: ref<TextPromptNotificationData> = GenericMessageNotification.GetBaseData();
  //   data.message = Deref(message);
  //   data.identifier = identifier;
  //   data.type = type;
  //   return controller.ShowGameNotification(data);
  // }
}