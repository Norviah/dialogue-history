module DialogueHistory.UI

import DialogueHistory.Core.Conversation


class ConversationSelectedEvent extends Event {
  public let m_conversation: wref<Conversation>;

  public static final func Create(conversation: wref<Conversation>) -> ref<ConversationSelectedEvent> {
    let event: ref<ConversationSelectedEvent> = new ConversationSelectedEvent();
    event.m_conversation = conversation;

    return event;
  }
}