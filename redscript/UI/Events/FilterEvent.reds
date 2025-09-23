module DialogueHistory.UI


class FilterEvent extends Event {
  public static final func Create() -> ref<FilterEvent> {
    return new FilterEvent();
  }
}