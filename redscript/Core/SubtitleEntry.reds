module DialogueHistory.Core


public class SubtitleEntry extends IScriptable {
  public let m_femaleVariant: String;

  public let m_maleVariant: String;

  public let m_path: String;

  public let m_stringId: CRUID;

  public let m_speaker: String;

  public let m_type: scnDialogLineType;

  public final func SetType(visualStyle: scnDialogLineVisualStyle, isHolocall: Bool) -> Void {
    this.m_type = isHolocall && Equals(visualStyle, scnDialogLineVisualStyle.regular) ? scnDialogLineType.Holocall : SubtitleEntry.VisualStyleToLineType(visualStyle);
  }

  public static final func VisualStyleToLineType(visualStyle: scnDialogLineVisualStyle) -> scnDialogLineType {
    switch visualStyle {
      case scnDialogLineVisualStyle.innerDialog:
      case scnDialogLineVisualStyle.regular:
        return scnDialogLineType.Regular;
      case scnDialogLineVisualStyle.overHead:
        return scnDialogLineType.OverHead;
      case scnDialogLineVisualStyle.radio:
        return scnDialogLineType.Radio;
      case scnDialogLineVisualStyle.globalTV:
        return scnDialogLineType.GlobalTV;
      case scnDialogLineVisualStyle.invisible:
        return scnDialogLineType.Invisible;
      case scnDialogLineVisualStyle.overHeadAlwaysVisible:
        return scnDialogLineType.OverHeadAlwaysVisible;
      case scnDialogLineVisualStyle.overHeadAlwaysVisible:
        return scnDialogLineType.OverHeadAlwaysVisible;
      case scnDialogLineVisualStyle.alwaysCinematicNoSpeaker:
        return scnDialogLineType.AlwaysCinematicNoSpeaker;
      case scnDialogLineVisualStyle.globalTVAlwaysVisible:
        return scnDialogLineType.GlobalTVAlwaysVisible;
      case scnDialogLineVisualStyle.narrator:
        return scnDialogLineType.Narrator;
    }

    return scnDialogLineType.None;
  }

  public static final func Initialize(path: String, source: localizationPersistenceSubtitleEntry) -> ref<SubtitleEntry> {
    let entry = new SubtitleEntry();
    entry.m_femaleVariant = source.femaleVariant;
    entry.m_maleVariant = source.maleVariant;
    entry.m_path = path;
    entry.m_stringId = source.stringId;

    return entry;
  }
}
