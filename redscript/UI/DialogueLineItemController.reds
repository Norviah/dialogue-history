module DialogueHistory.UI

import DialogueHistory.Core.Config
import DialogueHistory.Structs.{ColorToName, DialogueLine, TimeFormat, TimeStamp}


public class DialogueLineItemController extends ListItemController {
  private let m_textRef: inkTextRef;

  private let m_nameRef: inkTextRef;

  private let m_timeRef: inkTextRef;

  private let m_config: wref<Config>;

  public cb func OnInitialize() -> Void {
    this.m_config = Config.GetInstance();
  }

  public cb func OnUninitialize() -> Void {
    this.m_config = null;
  }

  public cb func OnDataChanged(value: ref<IScriptable>) -> Bool {
    let data: ref<DialogueLineData> = value as DialogueLineData;
    let line: DialogueLine = data.m_line;

    let speakerName: String = GetLocalizedText(NameToString(line.speakerName));

    this.m_textRef.widget.BindProperty(n"tintColor", ColorToName(this.m_config.textColor));
    this.m_nameRef.widget.BindProperty(n"tintColor", ColorToName(Equals(speakerName, "V") ? this.m_config.vSpeakerColor : this.m_config.GetColor(line.type)));
    this.m_timeRef.widget.BindProperty(n"tintColor", ColorToName(this.m_config.timeColor));

    this.m_textRef.SetWrappingAtPosition(this.m_config.subtitleTextLength);

    inkTextRef.SetText(this.m_textRef, NameToString(line.text));
    inkTextRef.SetText(this.m_nameRef, s"\(speakerName):");
    inkTextRef.SetText(this.m_timeRef, TimeStamp.FormatTime(line.timestamp, this.m_config.timeFormat));

    inkWidgetRef.SetVisible(this.m_timeRef, this.m_config.showTimestamps);
  }
}