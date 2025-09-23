module DialogueHistory.Annotations


@wrapMethod(gameuiInGameMenuGameController)
private final func RegisterInputListenersForPlayer(playerPuppet: ref<GameObject>) -> Void {
	wrappedMethod(playerPuppet);

	if playerPuppet.IsControlledByLocalPeer() {
		playerPuppet.RegisterInputListener(this, n"OpenDialogueHistory");
	}
}

@wrapMethod(gameuiInGameMenuGameController)
protected cb func OnAction(action: ListenerAction, consumer: ListenerActionConsumer) -> Bool {
	wrappedMethod(action, consumer);

	let actionName: CName = ListenerAction.GetName(action);
	let actionType: gameinputActionType = ListenerAction.GetType(action);

	if Equals(actionName, n"OpenDialogueHistory") && Equals(actionType, gameinputActionType.BUTTON_PRESSED) {
    this.OpenDialogueHistoryMenu();
    ListenerActionConsumer.DontSendReleaseEvent(consumer);
	}
}

@wrapMethod(gameuiInGameMenuGameController)
protected cb func OnHandleMenuInput(evt: ref<inkPointerEvent>) -> Bool {
  wrappedMethod(evt);

  if evt.IsAction(n"toggle_dialogue_history") && (!evt.IsHandled() || !evt.IsConsumed()) {
    this.SpawnMenuInstanceEvent(n"OnHotkeySwitchToDialogueHistory");
    evt.Handle();
    evt.Consume();
  }
}

@addMethod(gameuiInGameMenuGameController)
public func OpenDialogueHistoryMenu() -> Void {
  let eventName: CName = GetFact(this.m_player.GetGame(), n"radial_hub_menu_enabled") > 0 ? n"OnOpenRadialHubMenu_InitData" : n"OnOpenHubMenu_InitData";
  let initData: ref<HubMenuInitData> = new HubMenuInitData();
  initData.m_menuName = n"dialogue_history";
  initData.m_combatRestriction = this.IsPlayerInCombat();

  this.SpawnMenuInstanceDataEvent(eventName, initData);
}

@addMethod(MenuScenario_HubMenu)
protected cb func OnHotkeySwitchToDialogueHistory() -> Bool {
  this.ToggleMenu(n"dialogue_history");
}

@addMethod(MenuScenario_RadialHubMenu)
protected cb func OnHotkeySwitchToDialogueHistory() -> Bool {
  this.ToggleMenu(n"dialogue_history");
}