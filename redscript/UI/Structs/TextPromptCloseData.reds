module DialogueHistory.UI


class TextPromptCloseData extends GenericMessageNotificationCloseData {
  public let text: String;

  public let item: ref<ConversationListItemController>;
}