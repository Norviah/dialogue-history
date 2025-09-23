module DialogueHistory.Structs


/// References the specific area of where a dialogue line was spoken in.
///
/// Of course, the player will hear dialogue lines in various locations around
/// Night City. `Area` holds references to the area of where a line was spoken in
/// for future reference.
///
/// An area is defined into three parts (if/when applicable):
/// - `place`: The specific place where the line was spoken, e.g. Afterlife.
/// - `subdistrict`: The sub-district where the line was spoken, e.g. Little China.
/// - `district`: The district where the line was spoken, e.g. Watson.
public struct Area {
  /// The building/place that the line was spoken in.
  ///
  /// This represents the SPECIFIC place, if applicable. For example,
  /// Viktor's clinic.
  public persistent let place: CName;

  /// The sub-district that the line was spoken in.
  public persistent let subdistrict: CName;

  /// The district that the line was spoken in.
  public persistent let district: CName;

  /// Determines if an `Area` is valid.
  ///
  /// There are some points in Night City that has no designated location, which
  /// is assigned the CName "None". This method ensures whetehr if an area is
  /// valid by ensuring it has at-least one valid property.
  public static func IsValid(area: Area) -> Bool {
    return NotEquals(area.place, n"None") && NotEquals(area.subdistrict, n"None") && NotEquals(area.district, n"None");
  }

  /// Converts an `Area` to a string.
  ///
  /// This method attempts to convert the specified `Area` into a string with
  /// the format of `place, subdistrict` or `subdistrict, district`. Note that the
  /// method assumes that the area is valid.
  ///
  /// If the area is not valid, as in all properties are an empty string, then
  /// empty string is returned.
  public static func ToString(area: Area) -> String {
    let hasPlace: Bool = NotEquals(area.place, n"None");
    let hasDistrict: Bool = NotEquals(area.district, n"None");
    let hasSubdistrict: Bool = NotEquals(area.subdistrict, n"None");

    let string: String = "";

    if hasPlace || hasSubdistrict {
      string = GetLocalizedText(NameToString(hasPlace ? area.place : area.subdistrict));
    }

    if hasSubdistrict || hasDistrict {
      string = s"\(string)\(NotEquals(string, "") ? ", " : "")\(GetLocalizedText(NameToString(hasSubdistrict && !hasPlace ? area.district : area.subdistrict)))";
    }

    return string;
  }

  /// Initializes a new `Area` instance.
  public static final func Initialize(district: ref<District_Record>) -> Area {
    let area: Area;

    let parent: ref<District_Record> = district.ParentDistrictHandle();
    let grandparent: ref<District_Record> = parent.ParentDistrictHandle();

    if IsDefined(grandparent) {
      area.place = StringToName(district.LocalizedName());
      area.subdistrict = StringToName(parent.LocalizedName());
      area.district = StringToName(grandparent.LocalizedName());
    } else if IsDefined(parent) {
      area.subdistrict = StringToName(district.LocalizedName());
      area.district = StringToName(parent.LocalizedName());
    } else {
      area.district = StringToName(district.LocalizedName());
    }

    return area;
  }
}