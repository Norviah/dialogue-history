module DialogueHistory.UI


class DeleteConversationEvent extends Event {
  public let m_data: wref<ConversationListItemData>;

  public static final func Create(conversation: wref<ConversationListItemData>) -> ref<DeleteConversationEvent> {
    let event: ref<DeleteConversationEvent> = new DeleteConversationEvent();
    event.m_data = conversation;

    return event;
  }
}