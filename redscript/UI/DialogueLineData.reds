module DialogueHistory.UI

import DialogueHistory.Structs.DialogueLine


public class DialogueLineData extends IScriptable {
  public let m_line: DialogueLine;

  public static final func Create(line: DialogueLine) -> ref<DialogueLineData> {
    let buffer: ref<DialogueLineData> = new DialogueLineData();
    buffer.m_line = line;

    return buffer;
  }
}