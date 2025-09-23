module DialogueHistory.Annotations

import DialogueHistory.Core.History


@addField(BaseSubtitlesGameController)
public let m_history: ref<History>;

@addField(BaseSubtitlesGameController)
public let m_lastCRUID: CRUID;


@wrapMethod(BaseSubtitlesGameController)
protected cb func OnInitialize() -> Bool {
  wrappedMethod();

  if IsDefined(this.GetPlayerControlledObject()) {
    this.m_history = History.GetInstance(this.m_gameInstance);
  }
}

@wrapMethod(BaseSubtitlesGameController)
protected cb func OnUninitialize() -> Bool {
  wrappedMethod();

  if IsDefined(this.m_history) {
    this.m_history = null;
  }
}

@wrapMethod(BaseSubtitlesGameController)
private final func SpawnDialogLine(const rawLineData: script_ref<scnDialogLineData>) -> Void {
  wrappedMethod(rawLineData);

  let lineData: scnDialogLineData = Deref(rawLineData);

  if NotEquals(lineData.id, this.m_lastCRUID) {
    this.m_history.AddLine(lineData);
    this.m_lastCRUID = lineData.id;
  }
}