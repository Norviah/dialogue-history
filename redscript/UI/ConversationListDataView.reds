module DialogueHistory.UI

import DialogueHistory.Core.Conversation
import DialogueHistory.Structs.{Area, ConversationFilterCategory, DialogueLine, DialogueLineTypeToCategory}


class ConversationListDataView extends ScriptableDataView {
  private let m_category: ConversationFilterCategory = ConversationFilterCategory.All;

  private let m_searchTerm: String = "";

  private let m_saveFilter: Bool;

  public func Setup(filter: ConversationFilterCategory) -> Void {
    this.m_category = filter;
  }

  public func IsDefaultCategory() -> Bool {
    return Equals(this.m_category, ConversationFilterCategory.All);
  }

  public func HasSearchTerm() -> Bool {
    return StrLen(this.m_searchTerm) > 0;
  }

  public func IsSavedFilterEnabled() -> Bool {
    return this.m_saveFilter;
  }

  public func HasFilters() -> Bool {
    return !this.IsDefaultCategory() || this.IsSavedFilterEnabled() || this.HasSearchTerm();
  }

  public func SetCategoryFilter(category: ConversationFilterCategory) -> Void {
    this.m_category = category;
    this.Filter();
  }

  public func SetSavedConversationsFilter(toggled: Bool) -> Void {
    this.m_saveFilter = toggled;
    this.Filter();
  }

  public func SetSearchTerm(term: String) -> Void {
    this.m_searchTerm = UTF8StrUpper(term);
    this.Filter();
  }

  protected func IsLineFrom(line: DialogueLine) -> Bool {
    return StrContains(UTF8StrUpper(GetLocalizedText(NameToString(line.speakerName))), this.m_searchTerm);
  }

  protected func DoesLineHave(line: DialogueLine) -> Bool {
    return StrContains(UTF8StrUpper(NameToString(line.text)), this.m_searchTerm);
  }

  protected func IsLineAt(line: DialogueLine) -> Bool {
    if NotEquals(line.area.place, n"None") && StrContains(UTF8StrUpper(GetLocalizedText(NameToString(line.area.place))), this.m_searchTerm) {
      return true;
    } else if NotEquals(line.area.subdistrict, n"None") && StrContains(UTF8StrUpper(GetLocalizedText(NameToString(line.area.subdistrict))), this.m_searchTerm) {
      return true;
    } else if NotEquals(line.area.district, n"None") && StrContains(UTF8StrUpper(GetLocalizedText(NameToString(line.area.district))), this.m_searchTerm) {
      return true;
    }

    return false;
  }

  public func ConversationHasTerm(conversation: wref<Conversation>) -> Bool {
    let lines: [DialogueLine] = conversation.GetLines();

    if conversation.HasCustomTitle() && StrContains(UTF8StrUpper(conversation.GetCustomTitle()), this.m_searchTerm) {
      return true;
    }

    for line in lines {
      if this.IsLineFrom(line) || this.DoesLineHave(line) || this.IsLineAt(line) {
        return true;
      }
    }

    return false;
  }

  protected func ConversationHasCategory(conversation: wref<Conversation>) -> Bool {
    for type in conversation.GetTypes() {
      if Equals(this.m_category, DialogueLineTypeToCategory(type)) {
        return true;
      }
    }

    return false;
  }

  public func FilterItem(data: ref<IScriptable>) -> Bool {
    let conversation: wref<Conversation> = (data as ConversationListItemData).m_conversation;

    if this.m_saveFilter && !conversation.IsSaved() {
      return false;
    }

    if !this.IsDefaultCategory() && !this.ConversationHasCategory(conversation) {
      return false;
    }

    if this.HasSearchTerm() && !this.ConversationHasTerm(conversation) {
      return false;
    }

    return true;
  }

  public func SortItem(left: ref<IScriptable>, right: ref<IScriptable>) -> Bool {
    return true;
  }
}