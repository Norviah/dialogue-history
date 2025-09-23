module DialogueHistory.UI

import DialogueHistory.Structs.ConversationFilterCategory


class SavedFilterButtonClickedEvent extends Event {
  public let m_toggled: Bool;

  public static final func Create(toggled: Bool) -> ref<SavedFilterButtonClickedEvent> {
    let event: ref<SavedFilterButtonClickedEvent> = new SavedFilterButtonClickedEvent();
    event.m_toggled = toggled;

    return event;
  }
}