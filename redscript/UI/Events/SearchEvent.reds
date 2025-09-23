module DialogueHistory.UI


class SearchEvent extends Event {
  public let m_term: String;

  public static final func Create(term: String) -> ref<SearchEvent> {
    let event: ref<SearchEvent> = new SearchEvent();
    event.m_term = term;

    return event;
  }
}