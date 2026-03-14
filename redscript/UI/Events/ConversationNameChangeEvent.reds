module DialogueHistory.UI


class ConversationNameChangeEvent extends Event {
  public let m_controller: ref<ConversationListItemController>;

  public static final func Create(item: ref<ConversationListItemController>) -> ref<ConversationNameChangeEvent> {
    let event: ref<ConversationNameChangeEvent> = new ConversationNameChangeEvent();
    event.m_controller = item;

    return event;
  }
}