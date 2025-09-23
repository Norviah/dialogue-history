module DialogueHistory.Globals


/// Converts an array into a string.
///
/// Returns a new string by concatenating all of the elements in the given array,
/// separated by the specified separator string. If desired, a conjuction string
/// can also be specified to separate the final word.
///
/// Examples:
///   - `ArrayJoin(["John", "Henry", "Jared"], ",");    // => John, Henry, Jared
///   - `ArrayJoin(["John", "Henry", "Jared"], ",", &); // => John, Henry & Jared
public func ArrayJoin(array: [String], separator: String, opt conjuction: String) -> String {
  let size: Int32 = ArraySize(array);

  let i: Int32 = 0;
  let string: String = "";

  while i < size {
    let d: String = s"\(Equals(i, size - 1) && StrLen(conjuction) > 0 ? conjuction : separator)";
    let s: String = i > 0 ? s"\(d) " : "";
    string = s"\(string)\(s)\(array[i])";

    i = i + 1;
  }

  return string;
}