module DialogueHistory.Globals


/// Parses the given string into proper case.
///
/// When displaying subtitles, tv ads usually has the speaker names in all
/// lowercase and with underscores, for example: ad_arasaka. This helper
/// function will convert it to "Ad Arasaka", allowing for a better reading
/// experience when displaying subtitles.
public func StrToProperCase(string: String) -> String {
  let words: array<String> = StrSplit(string, "_");
  let string: String = "";

  let i: Int32 = 0;

  while i < ArraySize(words) {
    let word: String = words[i];
    let end: String = i < ArraySize(words) - 1 ? " " : "";
    string += StrFrontToUpper(word) + end;

    i += 1;
  }

  return string;
}