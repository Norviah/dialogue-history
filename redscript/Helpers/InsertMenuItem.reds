module DialogueHistory.Helpers


class InsertMenuItem extends ScriptableService {
  private cb func OnLoad() {
    GameInstance.GetCallbackSystem().RegisterCallback(n"Resource/Ready", this, n"OnMenuResourceReady").AddTarget(ResourceTarget.Path(r"base\\gameplay\\gui\\fullscreen\\menu.inkmenu"));
  }

  private cb func OnMenuResourceReady(event: ref<ResourceEvent>) {
    let resource: ref<inkMenuResource> = event.GetResource() as inkMenuResource;
    let newMenuEntry: inkMenuEntry;
    newMenuEntry.depth = 0u;
    newMenuEntry.spawnMode = inkSpawnMode.SingleAndMultiplayer;
    newMenuEntry.isAffectedByFadeout = true;
    newMenuEntry.name = n"dialogue_history";
    newMenuEntry.menuWidget *= r"base\\gameplay\\gui\\fullscreen\\phone_quest_menu\\dialogue_history.inkwidget";

    ArrayPush(resource.menusEntries, newMenuEntry);
  }
}