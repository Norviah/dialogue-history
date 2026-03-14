module DialogueHistory.Annotations

import DialogueHistory.Core.{History, SubtitleEntry, SubtitleManager}


@addField(BaseSubtitlesGameController)
public let m_history: ref<History>;

@addField(BaseSubtitlesGameController)
public let m_subtitleManager: ref<SubtitleManager>;

@addField(BaseSubtitlesGameController)
public let m_lastCRUID: CRUID;

@addField(BaseSubtitlesGameController)
public let m_ignoredLines: [String];


@wrapMethod(BaseSubtitlesGameController)
protected cb func OnInitialize() -> Bool {
  wrappedMethod();

  if !IsDefined(this.GetPlayerControlledObject()) {
    return false;
  }

  this.m_history = History.GetInstance(this.m_gameInstance);
  this.m_subtitleManager = SubtitleManager.GetInstance();
  this.m_ignoredLines = [GetLocalizedTextByKey(n"Story-OW-Grunts-Curious"), GetLocalizedTextByKey(n"Story-OW-Grunts-Phone"), GetLocalizedTextByKey(n"Story-OW-Grunts-Talk")];
}

@wrapMethod(BaseSubtitlesGameController)
protected cb func OnUninitialize() -> Bool {
  wrappedMethod();

  if IsDefined(this.m_history) {
    this.m_history = null;
  }

  if IsDefined(this.m_subtitleManager) {
    this.m_subtitleManager = null;
  }
}

@addMethod(BaseSubtitlesGameController)
protected func GetSubtitleEntryFromPool(lineData: scnDialogLineData, out subtitleEntry: ref<SubtitleEntry>) -> Bool {
  subtitleEntry = this.m_subtitleManager.GetEntryFromPool(lineData.text) as SubtitleEntry;

  if IsDefined(subtitleEntry) {
    this.m_subtitleManager.RemoveEntryFromPool(lineData.text);
    return true;
  } else {
    return false;
  }
}

@addMethod(BaseSubtitlesGameController)
protected func GetSubtitleEntryFromSource(lineData: scnDialogLineData, out subtitleEntry: ref<SubtitleEntry>) -> Bool {
  subtitleEntry = this.m_subtitleManager.m_subtitleEntries.Get(SubtitleManager.Hash(lineData.id)) as SubtitleEntry;

  return IsDefined(subtitleEntry);
}

@addMethod(BaseSubtitlesGameController)
protected func FindSubtitleEntryFromContainer(lineData: scnDialogLineData, out subtitleEntry: ref<SubtitleEntry>) -> Bool {
  let entries: [wref<IScriptable>];
  this.m_subtitleManager.m_subtitleEntries.GetValues(entries);

  for entry in entries {
    let line = entry as SubtitleEntry;

    if IsDefined(line) && (Equals(line.m_stringId, lineData.id) || Equals(line.m_femaleVariant, lineData.text) || Equals(line.m_maleVariant, lineData.text)) {
      subtitleEntry = line;
      return true;
    }
  }

  return false;
}

@addMethod(BaseSubtitlesGameController)
protected func FindSubtitleEntry(lineData: scnDialogLineData, out subtitleEntry: ref<SubtitleEntry>) -> Bool {
  return this.GetSubtitleEntryFromSource(lineData, subtitleEntry) || this.FindSubtitleEntryFromContainer(lineData, subtitleEntry);
}

@wrapMethod(BaseSubtitlesGameController)
private final func SpawnDialogLine(const rawLineData: script_ref<scnDialogLineData>) -> Void {
  wrappedMethod(rawLineData);

  let lineData: scnDialogLineData = Deref(rawLineData);

  if lineData.isPersistent || Equals(lineData.id, this.m_lastCRUID) {
    return;
  }

  this.m_lastCRUID = lineData.id;

  let subtitle: ref<SubtitleEntry>;
  let isLogged: Bool = this.GetSubtitleEntryFromPool(lineData, subtitle);

  let values: array<wref<IScriptable>>;
  this.m_subtitleManager.m_pool.GetValues(values);
  FTLog(s"already found: \(isLogged) | values from subtitle: \(ArraySize(values)) | should be ignored: \(ArrayContains(this.m_ignoredLines, lineData.text) )");

  if isLogged || ArrayContains(this.m_ignoredLines, lineData.text) {
    return;
  }

  this.FindSubtitleEntry(lineData, subtitle);

  FTLog(s" ");
  FTLog(s"BaseSubtitlesGameController::SpawnDialogLine | HAD TO FORCE LOOK");
  FTLog(s"path: \(subtitle.m_path)");
  FTLog(s"id: \(lineData.id)");
  FTLog(s"text: \(lineData.text)");
  FTLog(s"has speaker: \(IsDefined(lineData.speaker)) | name: \(IsDefined(lineData.speaker) ? GetLocalizedText(lineData.speaker.GetDisplayName()) : "NOT DEFINED")");
  FTLog(s"speaker: \(lineData.speaker.GetDisplayName()) | \(lineData.speakerName)");
  FTLog(s"type: \(lineData.type) | \(StrLen(ToString(lineData.type))) | \(IsStringValid(ToString(lineData.type)))");
  FTLog(s" ");

  if !IsDefined(subtitle) {
    return;
  }

  lineData.type = Equals(subtitle.m_type, scnDialogLineType.Holocall) ? subtitle.m_type : lineData.type;

  this.m_history.AddLine(lineData, subtitle.m_path);
}