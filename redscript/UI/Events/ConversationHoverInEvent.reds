module DialogueHistory.UI

import DialogueHistory.Core.Conversation


class ConversationHoverInEvent extends Event {
  public let m_conversation: wref<Conversation>;

  public static final func Create(conversation: wref<Conversation>) -> ref<ConversationHoverInEvent> {
    let event: ref<ConversationHoverInEvent> = new ConversationHoverInEvent();
    event.m_conversation = conversation;

    return event;
  }
}