module DialogueHistory.UI


class ResetButtonHintsEvent extends Event {
  public static final func Create() -> ref<ResetButtonHintsEvent> {
    return new ResetButtonHintsEvent();
  }
}