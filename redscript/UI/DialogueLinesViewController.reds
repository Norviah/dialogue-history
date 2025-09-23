module DialogueHistory.UI

import DialogueHistory.Core.Conversation
import DialogueHistory.Structs.DialogueLine


public class DialogueLinesViewController extends inkLogicController {
  private let m_messagesListRef: inkCompoundRef;

  private let m_messagesListController: wref<ListController>;

  private let m_scrollController: wref<inkScrollController>;

  protected cb func OnInitialize() -> Bool {
    this.m_messagesListController = inkWidgetRef.GetController(this.m_messagesListRef) as ListController;
    this.m_scrollController = this.GetRootWidget().GetControllerByType(n"inkScrollController") as inkScrollController;
  }

  public final func Clear() -> Void {
    this.m_messagesListController.Clear(true);
  }

  public func ConversationToIScriptable(conversation: wref<Conversation>) -> [ref<IScriptable>] {
    let data: [ref<IScriptable>] = [];

    for line in conversation.GetLines() {
      ArrayPush(data, DialogueLineData.Create(line));
    }

    return data;
  }

  public func PopulateData(conversation: wref<Conversation>) -> Void {
    this.Clear();
    this.m_messagesListController.PushDataList(this.ConversationToIScriptable(conversation), true);
    this.m_scrollController.SetScrollPosition(1.0);
  }
}