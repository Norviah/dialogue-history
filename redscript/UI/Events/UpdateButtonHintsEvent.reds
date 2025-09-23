module DialogueHistory.UI

import DialogueHistory.Core.Conversation


class UpdateButtonHintsEvent extends Event {
  public let m_conversation: wref<Conversation>;

  public static final func Create(conversation: wref<Conversation>) -> ref<UpdateButtonHintsEvent> {
    let event: ref<UpdateButtonHintsEvent> = new UpdateButtonHintsEvent();
    event.m_conversation = conversation;

    return event;
  }
}