module DialogueHistory.UI

import Codeware.UI.inkCustomController
import DialogueHistory.Core.{Conversation, Config, History}
import DialogueHistory.Structs.{ConversationFilterCategory, DialogueLine}


public class DialogueHistoryMenuController extends gameuiMenuGameController {
  protected let m_buttonHintsManagerRef: inkWidgetRef;

  protected let m_virtualListRef: inkWidgetRef;

  protected let m_dialogRef: inkWidgetRef;

  protected let m_filtersRootRef: inkCanvasRef;

  protected let m_filtersContainerRef: inkHorizontalPanelRef;

  protected let m_listWrapperRef: inkCanvasRef;

  protected let m_noDataAvailableTextRef: inkTextRef;

  protected let m_tooltipsManagerRef: inkCanvasRef;

  protected let m_tooltipsContainerRef: inkHorizontalPanelRef;

  protected let m_savedFilterButtonRef: inkCanvasRef;

  protected let m_filterDropdownButtonRef: inkWidgetRef;

  protected let m_filterDropdownContainerRef: inkWidgetRef;

  protected let m_filterDropdownController: wref<DropdownListController>;

  protected let m_filterButtonController: wref<DropdownButtonController>;

  protected let m_dropdownFilterOptions: [ref<DropdownItemData>];

  protected let m_savedFilterButtonController: wref<SavedFilterButtonController>;

  protected let m_tooltipsManager: wref<gameuiTooltipsManager>;

  protected let m_buttonHintsController: wref<ButtonHints>;

  protected let m_dialogController: wref<DialogueLinesViewController>;

  protected let m_listController: wref<inkVirtualListController>;

  protected let m_menuEventDispatcher: wref<inkMenuEventDispatcher>;

  protected let m_history: wref<History>;

  protected let m_conversationListDataView: ref<ConversationListDataView>;

  protected let m_conversationListDataSource: ref<ScriptableDataSource>;

  protected let m_conversationListTemplateClassifier: ref<inkVirtualItemTemplateClassifier>;

  protected let m_resetConfirmationToken: ref<inkGameNotificationToken>;

  protected let m_dataToDelete: wref<ConversationListItemData>;

  protected let m_config: wref<Config>;

  public let m_selectedConversation: wref<Conversation>;



  public cb func OnInitialize() -> Bool {
    let game: GameInstance = this.GetPlayerControlledObject().GetGame();

    this.m_history = History.GetInstance(game);
    this.m_config = Config.GetInstance();

    let hintsWidget: wref<inkWidget> = this.SpawnFromExternal(inkWidgetRef.Get(this.m_buttonHintsManagerRef), r"base\\gameplay\\gui\\common\\buttonhints.inkwidget", n"Root");
    this.m_buttonHintsController = hintsWidget.GetController() as ButtonHints;
    this.m_dialogController = inkWidgetRef.GetController(this.m_dialogRef) as DialogueLinesViewController;
    this.m_listController = inkWidgetRef.GetController(this.m_virtualListRef) as inkVirtualListController;

    this.m_tooltipsManager = inkWidgetRef.GetControllerByType(this.m_tooltipsManagerRef, n"gameuiTooltipsManager") as gameuiTooltipsManager;
    this.m_tooltipsManager.Setup(ETooltipsStyle.Menus);

    this.m_savedFilterButtonController = inkWidgetRef.GetController(this.m_savedFilterButtonRef) as SavedFilterButtonController;
    this.m_savedFilterButtonController.Setup(this.m_tooltipsManager);

    this.InitializeList();
    this.SetupSearchInput();
    this.SetupSortingDropdown();
    this.ResetButtonHints();

    inkTextRef.SetText(this.m_noDataAvailableTextRef, GetLocalizedTextByKey(n"DialogueHistory-UI-EmptyHistory"));

    this.PopulateData(true);
  }

  public cb func OnUninitialize() -> Bool {
    this.UninitializeList();
    this.m_dropdownFilterOptions = [];
    this.m_menuEventDispatcher.UnregisterFromEvent(n"OnBack", this, n"OnBack");
  }

  public cb func OnSetMenuEventDispatcher(menuEventDispatcher: wref<inkMenuEventDispatcher>) -> Bool {
    this.m_menuEventDispatcher = menuEventDispatcher;
    this.m_menuEventDispatcher.RegisterToEvent(n"OnBack", this, n"OnBack");
  }

  public cb func OnBack(userData: ref<IScriptable>) -> Bool {
    if !StatusEffectSystem.ObjectHasStatusEffectWithTag(this.GetPlayerControlledObject(), n"LockInHubMenu") {
      this.m_menuEventDispatcher.SpawnEvent(n"OnCloseHubMenu");
    };
  }



  protected func InitializeList() -> Void {
    this.m_conversationListDataSource = new ScriptableDataSource();
    this.m_conversationListDataView = new ConversationListDataView();
    this.m_conversationListDataView.Setup(this.m_config.defaultFilter);
    this.m_conversationListDataView.SetSource(this.m_conversationListDataSource);
    this.m_conversationListTemplateClassifier = new ConversationListTemplateClassifier();

    this.m_listController.SetClassifier(this.m_conversationListTemplateClassifier);
    this.m_listController.SetSource(this.m_conversationListDataView);
  }

  protected func UninitializeList() -> Void {
    this.m_conversationListDataSource.Clear();
    this.m_conversationListDataView.SetSource(null);
    this.m_listController.SetSource(null);
    this.m_listController.SetClassifier(null);

    this.m_conversationListDataView = null;
    this.m_conversationListDataSource = null;
    this.m_conversationListTemplateClassifier = null;
  }

  protected func SetupSearchInput() -> Void {
    SearchInput.Create().Reparent(this.m_filtersRootRef.widget as inkCompoundWidget, this);
  }

  protected func SetDropdownData() -> Void {
    ArrayPush(this.m_dropdownFilterOptions, this.GetDropdownItemData(ToVariant(ConversationFilterCategory.All), StringToName(GetLocalizedTextByKey(n"DialogueHistory-Filter-All")), DropdownItemDirection.None));
    ArrayPush(this.m_dropdownFilterOptions, this.GetDropdownItemData(ToVariant(ConversationFilterCategory.Main), StringToName(GetLocalizedTextByKey(n"DialogueHistory-Filter-Main")), DropdownItemDirection.None));
    ArrayPush(this.m_dropdownFilterOptions, this.GetDropdownItemData(ToVariant(ConversationFilterCategory.Media), StringToName(GetLocalizedTextByKey(n"DialogueHistory-Filter-Media")), DropdownItemDirection.None));
    ArrayPush(this.m_dropdownFilterOptions, this.GetDropdownItemData(ToVariant(ConversationFilterCategory.Background), StringToName(GetLocalizedTextByKey(n"DialogueHistory-Filter-Background")), DropdownItemDirection.None));
    ArrayPush(this.m_dropdownFilterOptions, this.GetDropdownItemData(ToVariant(ConversationFilterCategory.Other), StringToName(GetLocalizedTextByKey(n"DialogueHistory-Filter-Other")), DropdownItemDirection.None));
  }

  private final func GetDropdownItemData(identifier: Variant, labelKey: CName, direction: DropdownItemDirection) -> ref<DropdownItemData> {
    let itemData: ref<DropdownItemData> = new DropdownItemData();
    itemData.identifier = identifier;
    itemData.labelKey = labelKey;
    itemData.direction = direction;
    return itemData;
  }

  protected func GetDropdownOption(id: ConversationFilterCategory)  -> ref<DropdownItemData> {
    for data in this.m_dropdownFilterOptions {
      if Equals(FromVariant<ConversationFilterCategory>(data.identifier), id) {
        return data;
      }
    }

    return null;
  }

  protected final func SetupSortingDropdown() -> Void {
    this.SetDropdownData();

    inkWidgetRef.RegisterToCallback(this.m_filterDropdownButtonRef, n"OnRelease", this, n"OnFilterDropdownButtonClicked");
    this.m_filterDropdownController = inkWidgetRef.GetController(this.m_filterDropdownContainerRef) as DropdownListController;
    this.m_filterButtonController = inkWidgetRef.GetController(this.m_filterDropdownButtonRef) as DropdownButtonController;
    this.m_filterDropdownController.Setup(this, this.m_dropdownFilterOptions, this.m_filterButtonController, this.m_config.defaultFilter);
    this.m_filterButtonController.SetData(this.GetDropdownOption(this.m_config.defaultFilter));

    inkWidgetRef.RegisterToCallback(this.m_filterDropdownContainerRef, n"OnHoverOut", this, n"OnFilterDropdownToggle");
    inkWidgetRef.RegisterToCallback(this.m_filterDropdownContainerRef, n"OnHoverOver", this, n"OnFilterDropdownToggle");
  }


  protected final func PlayAnimation() -> Void {
    this.PlayLibraryAnimation(n"contacts_intro");
  }

  public func ResetButtonHints() -> Void {
    this.m_buttonHintsController.ClearButtonHints();
    this.m_buttonHintsController.AddButtonHint(n"back", GetLocalizedText("Common-Access-Close"));
  }

  protected final func HideData() -> Void {
    inkWidgetRef.SetVisible(this.m_dialogRef, false);
    inkWidgetRef.SetVisible(this.m_filtersRootRef, false);
    inkWidgetRef.SetVisible(this.m_listWrapperRef, false);
  }

  protected final func ShowData() -> Void {
    inkWidgetRef.SetVisible(this.m_dialogRef, true);
    inkWidgetRef.SetVisible(this.m_filtersRootRef, true);
    inkWidgetRef.SetVisible(this.m_listWrapperRef, true);
  }

  protected final func ShowNoDataWarning() -> Void {
    this.HideData();
    inkWidgetRef.SetVisible(this.m_noDataAvailableTextRef, true);
  }

  protected func ShowConversation(ref: wref<Conversation>) -> Void {
    this.m_selectedConversation = ref;

    this.QueueEvent(new MessengerContactSyncBackEvent());
    this.m_buttonHintsController.RemoveButtonHint(n"click");

    this.m_dialogController.PopulateData(ref);
  }

  protected final func PostConversationDeleted() -> Void {
    let size: Uint32 = this.m_conversationListDataSource.Size();

    if Equals(size, 0u) {
      this.ShowNoDataWarning();
    } else if !IsDefined(this.m_selectedConversation) {
      this.ShowConversation((this.m_conversationListDataSource.GetItem(0u) as ConversationListItemData).m_conversation);
    }
  }

  protected final func GetData() -> [ref<IScriptable>] {
    let conversations: [ref<Conversation>] = this.m_history.GetConversations();

    let data: [ref<IScriptable>] = [];
    let i: Int32 = ArraySize(conversations);

    while i > 0 {
      let item: ref<ConversationListItemData> = new ConversationListItemData();
      item.m_menuController = this;
      item.m_conversation = conversations[i - 1];

      ArrayPush(data, item);

      i = i - 1;
    }

    return data;
  }

  protected final func PopulateData(playAnimation: Bool) -> Void {
    let data: [ref<IScriptable>] = this.GetData();

    if ArraySize(data) > 0 {
      this.m_conversationListDataSource.Reset(data);

      let recentConversationData = data[0] as ConversationListItemData;
      let recentConversation = recentConversationData.m_conversation;

      this.ShowConversation(recentConversation);
      this.ShowData();
    } else {
      this.ShowNoDataWarning();
    }

    if playAnimation {
      this.PlayAnimation();
    }
  }



  protected cb func OnSearch(event: ref<SearchEvent>) -> Bool {
    this.m_conversationListDataView.SetSearchTerm(event.m_term);
  }

  protected cb func OnSavedFilterButtonClicked(e: ref<SavedFilterButtonClickedEvent>) -> Bool {
    this.m_conversationListDataView.SetSavedConversationsFilter(e.m_toggled);
  }

  protected cb func OnConversationSelected(event: ref<ConversationSelectedEvent>) -> Bool {
    this.ShowConversation(event.m_conversation);
  }

  protected cb func OnUpdateButtonHints(event: ref<UpdateButtonHintsEvent>) -> Bool {
    this.ResetButtonHints();

    this.m_buttonHintsController.AddButtonHint(n"UI_smart_frame_remove", GetLocalizedTextByKey(event.m_conversation.IsSaved() ? n"DialogueHistory-UI-UnsaveConversation" : n"DialogueHistory-UI-SaveConversation")); // R / Y / Triangle
    this.m_buttonHintsController.AddButtonHint(n"upgrade_cyberware", GetLocalizedTextByKey(n"DialogueHistory-UI-DeletePrompt-Label")); // E / X / Square

    if NotEquals(this.m_selectedConversation, event.m_conversation) {
      this.m_buttonHintsController.AddButtonHint(n"click", GetLocalizedTextByKey(n"DialogueHistory-UI-ShowConversation"));
    }
  }

  protected cb func OnResetButtonHints(event: ref<ResetButtonHintsEvent>) -> Bool {
    this.ResetButtonHints();
  }

  protected cb func OnFilter(event: ref<FilterEvent>) -> Bool {
    if this.m_conversationListDataView.IsSavedFilterEnabled() {
      this.m_conversationListDataView.Filter();
    }
  }

  protected cb func OnFilterDropdownButtonClicked(event: ref<inkPointerEvent>) -> Bool {
    if event.IsAction(n"click") {
      this.m_filterDropdownController.Toggle();
      this.PlaySound(n"Button", n"OnPress");
    };
  }

  protected cb func OnFilterDropdownToggle(event: ref<inkPointerEvent>) -> Bool {
    if Equals(event.GetTarget(), this.m_filterDropdownController.GetRootWidget()) {
      inkWidgetRef.SetOpacity(this.m_virtualListRef, this.m_filterDropdownController.IsOpened() ? 0.15 : 1.0);
    };
  }

  protected cb func OnFilterDropdownItemClicked(event: ref<DropdownItemClickedEvent>) -> Bool {
    let identifier: ConversationFilterCategory = FromVariant<ConversationFilterCategory>(event.identifier);
    let data: ref<DropdownItemData> = this.GetDropdownOption(identifier);

    if IsDefined(data) {
      this.m_filterButtonController.SetData(data);
      this.m_conversationListDataView.SetCategoryFilter(identifier);
      this.PlaySound(n"Button", n"OnPress");
    };
  }

  protected cb func OnConversationDeletePrompt(event: ref<DeleteConversationEvent>) -> Void {
    if IsDefined(this.m_resetConfirmationToken) {
      return;
    }

    this.m_dataToDelete = event.m_data;

    let title: String = GetLocalizedTextByKey(n"DialogueHistory-UI-DeletePrompt-Title");
    let description: String = StrReplaceAll(GetLocalizedTextByKey(n"DialogueHistory-UI-DeletePrompt-Description"), "{NAME}", event.m_data.m_conversation.GetNames());

    this.m_resetConfirmationToken = GenericMessageNotification.Show(this, title, description, GenericMessageNotificationType.ConfirmCancel);
    this.m_resetConfirmationToken.RegisterListener(this, n"OnDeletePromptClosed");
  }

  protected cb func OnDeletePromptClosed(data: ref<inkGameNotificationData>) -> Bool {
    let resultData: ref<GenericMessageNotificationCloseData> = data as GenericMessageNotificationCloseData;

    if IsDefined(resultData) && Equals(resultData.result, GenericMessageNotificationResult.Confirm) {
      this.m_history.RemoveConversation(this.m_dataToDelete.m_conversation);
      this.m_conversationListDataSource.RemoveItem(this.m_dataToDelete);

      this.PostConversationDeleted();
    }

    this.m_dataToDelete = null;
    this.m_resetConfirmationToken = null;
  }
}