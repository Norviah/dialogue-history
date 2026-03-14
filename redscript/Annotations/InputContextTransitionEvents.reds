module DialogueHistory.Annotations

import DialogueHistory.Core.Config


@addField(InputContextTransitionEvents)
protected let m_dhConfig: ref<Config>;


@wrapMethod(InputContextTransitionEvents)
protected final func OnAttach(const stateContext: ref<StateContext>, const scriptInterface: ref<StateGameScriptInterface>) -> Void {
  wrappedMethod(stateContext, scriptInterface);

  this.m_dhConfig = Config.GetInstance();
}

@wrapMethod(InputContextTransitionEvents)
protected final func OnDetach(const stateContext: ref<StateContext>, const scriptInterface: ref<StateGameScriptInterface>) -> Void {
  wrappedMethod(stateContext, scriptInterface);

  this.m_dhConfig = null;
}

@addMethod(InputContextTransitionEvents)
protected final func IsDialogueHistoryInputHintDisplayed(stateContext: ref<StateContext>) -> Bool {
  return stateContext.GetBoolParameter(n"isDialogueHistoryInputHintDisplayed", true);
}

@addMethod(InputContextTransitionEvents)
protected final func SetDialogueHistoryInputHintFlag(stateContext: ref<StateContext>, value: Bool) -> Void {
  stateContext.SetPermanentBoolParameter(n"isDialogueHistoryInputHintDisplayed", value, true);
}

@addMethod(InputContextTransitionEvents)
protected final func OpenDialogueHistoryInputHints(stateContext: ref<StateContext>, scriptInterface: ref<StateGameScriptInterface>) -> Void {
  if this.IsDialogueHistoryInputHintDisplayed(stateContext) || !this.m_dhConfig.showInputHint {
    return;
  }

  this.ShowInputHint(scriptInterface, n"OpenDialogueHistory", n"DialogueHistory", GetLocalizedTextByKey(n"DialogueHistory-Action-Label"), inkInputHintHoldIndicationType.Press, true);
  this.SetDialogueHistoryInputHintFlag(stateContext, true);
}

@addMethod(InputContextTransitionEvents)
protected final func RemoveDialogueHistoryInputHints(stateContext: ref<StateContext>, scriptInterface: ref<StateGameScriptInterface>) -> Void {
  if !this.IsDialogueHistoryInputHintDisplayed(stateContext) {
    return;
  }

	this.RemoveInputHintsBySource(scriptInterface, n"DialogueHistory");
  this.SetDialogueHistoryInputHintFlag(stateContext, false);
}

@wrapMethod(InputContextTransitionEvents)
protected final func SetBaseContextInputHints(context: ActiveBaseContext, stateContext: ref<StateContext>, scriptInterface: ref<StateGameScriptInterface>) -> Void {
  // if NotEquals(context, ActiveBaseContext.None) {
  //   if this.m_dhConfig.showInputHint {
  //     this.OpenDialogueHistoryInputHints(stateContext, scriptInterface);
  //   } else if this.IsDialogueHistoryInputHintDisplayed(stateContext) {
  //     this.RemoveDialogueHistoryInputHints(stateContext, scriptInterface);
  //   }
  // }

  wrappedMethod(context, stateContext, scriptInterface);


  // if NotEquals(context, ActiveBaseContext.None) && this.m_dhConfig.showInputHint {
  //   FTLog(s"context: \(context)");
  //   this.OpenDialogueHistoryInputHints(stateContext, scriptInterface);
  // }

  // if NotEquals(context, ActiveBaseContext.None) && this.m_dhConfig.showInputHint {
  //   this.OpenDialogueHistoryInputHints(stateContext, scriptInterface);
  // }
}

@wrapMethod(InputContextTransitionEvents)
protected final const func ShowGenericExplorationInputHints(stateContext: ref<StateContext>, scriptInterface: ref<StateGameScriptInterface>) -> Void {
  // if Equals(stateContext.GetStateMachineCurrentState(n"CombatGadget"), n"combatGadgetCharge") {
  //   this.ShowInputHint(scriptInterface, n"CancelChargingCG", n"Locomotion", "LocKey#49906");
  // } else {
  //   if !this.IsEmptyHandsForced(stateContext, scriptInterface) {
  //     this.ShowInputHint(scriptInterface, n"SwitchItem", n"Locomotion", "LocKey#45381");
  //   };
  // };
  // this.ShowCrouchInputHint(stateContext, scriptInterface, n"Locomotion");
  // stateContext.SetPermanentBoolParameter(n"isLocomotionInputHintDisplayed", true, true);
  wrappedMethod(stateContext, scriptInterface);

  // this.OpenDialogueHistoryInputHints(stateContext, scriptInterface);
}

@wrapMethod(InputContextTransitionEvents)
protected final func RemoveAllInputHints(stateContext: ref<StateContext>, scriptInterface: ref<StateGameScriptInterface>) -> Void {
	wrappedMethod(stateContext, scriptInterface);
	this.RemoveDialogueHistoryInputHints(stateContext, scriptInterface);
}

@wrapMethod(InputContextTransitionEvents)
protected final const func ShowVehicleDriverInputHints(stateContext: ref<StateContext>, scriptInterface: ref<StateGameScriptInterface>) -> Void {
  this.OpenDialogueHistoryInputHints(stateContext, scriptInterface);
  wrappedMethod(stateContext, scriptInterface);
}

@wrapMethod(InputContextTransitionEvents)
protected final const func ShowVehicleRestrictedInputHints(stateContext: ref<StateContext>, scriptInterface: ref<StateGameScriptInterface>) -> Void {
  this.OpenDialogueHistoryInputHints(stateContext, scriptInterface);
  wrappedMethod(stateContext, scriptInterface);
}

@wrapMethod(InputContextTransitionEvents)
protected final const func ShowVehiclePassengerInputHints(stateContext: ref<StateContext>, scriptInterface: ref<StateGameScriptInterface>) -> Void {
  this.OpenDialogueHistoryInputHints(stateContext, scriptInterface);
  wrappedMethod(stateContext, scriptInterface);
}


@wrapMethod(BaseContextEvents)
private final func UpdateHints(stateContext: ref<StateContext>, scriptInterface: ref<StateGameScriptInterface>) -> Void {
  if this.ShouldForceRefreshInputHints(stateContext) {
    this.RemoveDialogueHistoryInputHints(stateContext, scriptInterface);
  }

  wrappedMethod(stateContext, scriptInterface);
}

// @wrapMethod(BaseContextEvents)
// private final func UpdateHints(stateContext: ref<StateContext>, scriptInterface: ref<StateGameScriptInterface>) -> Void {
// }