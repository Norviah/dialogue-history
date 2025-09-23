module DialogueHistory.Core


public struct SubtitleResource {
  /// The source path of the resource.
  public let m_path: String;

  /// The lines that belong to this resource.
  public let m_entries: [localizationPersistenceSubtitleEntry];

  public static final func IsValid(self: SubtitleResource) -> Bool {
    return NotEquals(self.m_path, "");
  }

  public static final func Has(self: SubtitleResource, line: scnDialogLineData) -> Bool {
    for entry in self.m_entries {
      if (Equals(entry.femaleVariant, line.text) || Equals(entry.maleVariant, line.text)) {
        return true;
      }
    }

    return false;
  }
}