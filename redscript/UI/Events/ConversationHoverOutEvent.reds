module DialogueHistory.UI


class ConversationHoverOutEvent extends Event {
  public static final func Create() -> ref<ConversationHoverOutEvent> {
    return new ConversationHoverOutEvent();
  }
}