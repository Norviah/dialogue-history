module DialogueHistory.Structs


public enum ConversationFilterCategory {
  All = 0,
  Main = 1,
  Media = 2,
  Background = 3,
  Other = 4,
}

public func DialogueLineTypeToCategory(type: scnDialogLineType) -> ConversationFilterCategory {
  switch type {
    case scnDialogLineType.Regular:
    case scnDialogLineType.Holocall:
    case scnDialogLineType.SceneComment:
    case scnDialogLineType.AlwaysCinematicNoSpeaker:
    case scnDialogLineType.Narrator:
      return ConversationFilterCategory.Main;

  case scnDialogLineType.Radio:
  case scnDialogLineType.GlobalTV:
  case scnDialogLineType.GlobalTVAlwaysVisible:
    return ConversationFilterCategory.Media;

  case scnDialogLineType.OverHead:
  case scnDialogLineType.OverHeadAlwaysVisible:
    return ConversationFilterCategory.Background;

  default:
    return ConversationFilterCategory.Other;
  }
}