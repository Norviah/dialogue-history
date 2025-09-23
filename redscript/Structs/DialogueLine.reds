module DialogueHistory.Structs


public struct DialogueLine {
  /// The name/source of the speaker.
  public persistent let speakerName: CName;

  /// The text of the line.
  public persistent let text: CName;

  /// The line's type, which indicates the context or nature of the line.
  public persistent let type: scnDialogLineType;

  /// The timestamp when the line was spoken.
  public persistent let timestamp: TimeStamp;

  /// The area where the line was spoken.
  public persistent let area: Area;
}