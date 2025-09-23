module DialogueHistory.Annotations


@wrapMethod(HubMenuUtility)
public final static func CreateMenuData(player: wref<PlayerPuppet>) -> ref<MenuDataBuilder> {
  return wrappedMethod(player).Add(HubMenuItems.Codex, HubMenuItems.Journal, n"dialogue_history", n"ico_data", n"Dialogue History");
}