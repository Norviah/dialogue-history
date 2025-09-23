module DialogueHistory.Core

import DialogueHistory.Structs.DialogueLine
import DialogueHistory.Globals.ArrayJoin


public class Conversation {
  private persistent let m_lines: [DialogueLine];

  private persistent let m_types: [scnDialogLineType];

  private persistent let m_resourcePath: CName;

  private persistent let m_saved: Bool;

  public final func AddLine(line: DialogueLine) -> Void {
    if !ArrayContains(this.m_types, line.type) {
      ArrayPush(this.m_types, line.type);
    }

    ArrayPush(this.m_lines, line);
  }

  public final func GetTypes() -> [scnDialogLineType] {
    return this.m_types;
  }

  public final func GetNames() -> String {
    let names: [String] = [];

    for line in this.m_lines {
      let name: String = GetLocalizedText(NameToString(line.speakerName));

      if !ArrayContains(names, name) {
        ArrayPush(names, name);
      }
    }

    return ArrayJoin(names, ",", " &");
  }

  public final func HasType(type: scnDialogLineType) -> Bool {
    return ArrayContains(this.m_types, type);
  }

  public final func GetFirstLine() -> DialogueLine {
    return this.m_lines[0];
  }

  public final func GetLastLine() -> DialogueLine {
    return ArrayLast(this.m_lines);
  }

  public final func GetLines() -> [DialogueLine] {
    return this.m_lines;
  }

  public final func IsSaved() -> Bool {
    return this.m_saved;
  }

  public final func ToggleSave() -> Void {
    this.m_saved = !this.m_saved;
  }

  public final func IsFromResourcePath(path: String) -> Bool {
    return Equals(this.m_resourcePath, StringToName(path));
  }

  public static final func Initialize(resourcePath: String) -> ref<Conversation> {
    let conversation: ref<Conversation> = new Conversation();
    conversation.m_types = [];
    conversation.m_resourcePath = StringToName(resourcePath);

    return conversation;
  }
}