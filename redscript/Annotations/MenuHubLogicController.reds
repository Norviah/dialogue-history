module DialogueHistory.Annotations


@wrapMethod(MenuHubLogicController)
protected cb func OnInitialize() -> Bool {
  wrappedMethod();
  this.AddDialogueHistoryMenuItem();
}

@addMethod(MenuHubLogicController)
private final func AddDialogueHistoryMenuItem() -> Void {
  let root: ref<inkCompoundWidget> = this.GetRootCompoundWidget();
  let panel: ref<inkCompoundWidget> = root.GetWidgetByPathName(n"mainMenu/buttonsContainer/panel_journal") as inkCompoundWidget;

  let menuItem: ref<inkCanvas> = this.SpawnFromLocal(panel, n"menu_button") as inkCanvas;
  menuItem.SetMargin(inkMargin(0.0, -170.0, 0.0, 0.0));
  menuItem.SetName(n"dialogue_history");

  let image: wref<inkImage> = menuItem.GetWidgetByPathName(n"inkFlexWidget4/container/image") as inkImage;
  image.SetAtlasResource(r"base\\gameplay\\gui\\common\\icons\\mappin_icons.inkatlas");

  let data: MenuData;
  data.disabled = false;
  data.fullscreenName = n"dialogue_history";
  data.identifier = 999;
  data.parentIdentifier = 5;
  data.label = "Dialogue History";
  data.icon = n"talk";

  (menuItem.GetController() as MenuItemController).Init(data);
}