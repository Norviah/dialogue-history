module DialogueHistory.Annotations

import DialogueHistory.Core.{History, SubtitleManager, SubtitleEntry}


@addField(GameObject)
protected let m_history: ref<History>;

@addField(GameObject)
protected let m_subtitleManager: ref<SubtitleManager>;

@addField(GameObject)
protected let m_lastSpokenDialogue: ref<SubtitleEntry>;


@wrapMethod(GameObject)
protected cb func OnGameAttached() -> Bool {
  wrappedMethod();

  this.m_history = History.GetInstance(this.GetGame());
  this.m_subtitleManager = SubtitleManager.GetInstance();
}

@wrapMethod(GameObject)
protected cb func OnDetach() -> Bool {
  this.m_history = null;
  this.m_subtitleManager = null;

  wrappedMethod();
}

@addMethod(GameObject)
protected func RemoveDialogueFromPool() -> Void {
  if IsDefined(this.m_lastSpokenDialogue) {
    this.m_subtitleManager.RemoveEntryFromPool(this.m_lastSpokenDialogue);
    this.m_lastSpokenDialogue = null;
  }
}

@addMethod(GameObject)
protected cb func OnDialogueLineEnd(event: ref<gameaudioeventsDialogLineEnd>) -> Bool {
  this.RemoveDialogueFromPool();
}

// @addMethod(GameObject)
// protected cb func OnStopDialogueLine(event: ref<gameaudioeventsStopDialogLine>) -> Bool {
//   this.RemoveDialogueFromPool();
// }

@addMethod(GameObject)
protected func GetDisplayName(subtitleEntry: ref<SubtitleEntry>) -> String {
  // if IsStringValid(subtitleEntry.m_speaker) && Equals(subtitleEntry.m_type, scnDialogLineType.Regular) {
  //   return subtitleEntry.m_speaker;
  // }

  let name: String = GetLocalizedText(this.GetDisplayName());

  if IsStringValid(name) {
    return name;
  }

  let puppet: ref<ScriptedPuppet> = this as ScriptedPuppet;
  let puppetRecord: ref<Character_Record> = puppet.GetRecord();

  if IsDefined(puppet) && IsDefined(puppetRecord) {
    return GetLocalizedTextByKey(puppetRecord.DisplayName());
  } else {
    return subtitleEntry.m_speaker;
  }
}

@addMethod(GameObject)
protected cb func OnDialogueLineEvent(event: ref<DialogLineEvent>) -> Bool {
  if !IsDefined(this.m_subtitleManager) || !IsDefined(this.m_history) {
    return false;
  }

  if IsDefined(this.m_lastSpokenDialogue) {
    this.RemoveDialogueFromPool();
  }

  let hash: Uint64 = SubtitleManager.Hash(event.data.stringId);
  let subtitle: ref<SubtitleEntry> = this.m_subtitleManager.m_subtitleEntries.Get(hash) as SubtitleEntry;
  
  let values: array<wref<IScriptable>>;
  this.m_subtitleManager.m_pool.GetValues(values);
  FTLog(s"values from object: \(ArraySize(values))");

  if !IsDefined(subtitle) {
    return false;
  }

  this.m_lastSpokenDialogue = subtitle;

  let lineData: scnDialogLineData;
  lineData.id = subtitle.m_stringId;
  lineData.isPersistent = false;
  lineData.speaker = this;
  lineData.speakerName = this.GetDisplayName(subtitle);
  lineData.text = this.m_subtitleManager.GetEntryText(subtitle);
  lineData.type = subtitle.m_type;

  this.m_subtitleManager.AddEntryToPool(lineData.text, subtitle);
  this.m_history.AddLine(lineData, subtitle.m_path);

  FTLog(s" ");
  FTLog(s"GameObject::OnDialogueLineEvent | Found From Source");
  FTLog(s"path: \(subtitle.m_path)");
  FTLog(s"id: \(lineData.id)");
  FTLog(s"text: \(lineData.text)");
  FTLog(s"type: \(lineData.type)");
  FTLog(s"speaker: \(lineData.speaker) | \(lineData.speaker.GetDisplayName()) | \(GetLocalizedText(lineData.speaker.GetDisplayName())) | \(lineData.speakerName)");
  FTLog(s"is player: \(this.IsPlayer()) | is johnny: \(this.IsJohnnyReplacer())");
  FTLog(s" ");
}

// @addMethod(GameObject)
// protected cb func OnVoiceOver(event: ref<SoundPlayVo>) -> Bool {
//   FTLog(s" ");
//   FTLog(s"OnVoiceOver");
//   FTLog(s"event.answeringEntityId.hash: \(event.answeringEntityId.hash)");
//   FTLog(s"event.debugInitialContext: \(event.debugInitialContext)");
//   FTLog(s"event.ignoreDistanceCheck: \(event.ignoreDistanceCheck)");
//   FTLog(s"event.ignoreFrustumCheck: \(event.ignoreFrustumCheck)");
//   FTLog(s"event.ignoreGlobalVoLimitCheck: \(event.ignoreGlobalVoLimitCheck)");
//   FTLog(s"event.isQuest: \(event.isQuest)");
//   FTLog(s"event.overrideVisualStyle: \(event.overrideVisualStyle)");
//   FTLog(s"event.overridingVisualStyleValue: \(event.overridingVisualStyleValue)");
//   FTLog(s"event.overridingVoiceoverContext: \(event.overridingVoiceoverContext)");
//   FTLog(s"event.overridingVoiceoverExpression: \(event.overridingVoiceoverExpression)");
//   FTLog(s"event.voContext: \(event.voContext)");
// }