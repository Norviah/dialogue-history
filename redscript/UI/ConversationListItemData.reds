module DialogueHistory.UI

import DialogueHistory.Core.Conversation


public class ConversationListItemData extends IScriptable {
  public let m_menuController: wref<DialogueHistoryMenuController>;

  public let m_conversation: wref<Conversation>;
}