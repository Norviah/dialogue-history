module DialogueHistory.Structs


public struct TimeStamp {
  /// The day the line was spoken.
  public persistent let day: Int32;

  /// The hour the line was spoken.
  public persistent let hour: Int32;

  /// The minute the line was spoken.
  public persistent let minute: Int32;

  /// Initializes a new `TimeStamp` instance.
  public static final func Initialize(gameTime: GameTime) -> TimeStamp {
    return TimeStamp(GameTime.Days(gameTime), GameTime.Hours(gameTime), GameTime.Minutes(gameTime));
  }

  /// A helper method to pad an integer into a two-digit string.
  ///
  /// Example:
  /// - `TimeStamp.PadTime(5)` -> `"05"`
  /// - `TimeStamp.PadTime(12)` -> `"12"`
  private static final func PadTime(time: Int32) -> String {
    return time < 10 ? s"0\(time)" : IntToString(time);
  }

  /// An internal method to convert a `TimeStamp` into a twelve-hour format.
  private static final func ToTwelveHourString(time: TimeStamp) -> String {
    return s"\(Equals(time.hour, 0) || Equals(time.hour, 12) ? 12 : time.hour % 12):\(TimeStamp.PadTime(time.minute)) \(time.hour >= 12 ? "PM" : "AM")";
  }

  /// An internal method to convert a `TimeStamp` into a twenty-four hour format.
  private static final func ToTwentyFourHourString(time: TimeStamp) -> String {
    return s"\(TimeStamp.PadTime(time.hour)):\(TimeStamp.PadTime(time.minute))";
  }

  /// Converts a `TimeStamp` into a string based on the specified format.
  public static final func FormatTime(time: TimeStamp, format: TimeFormat) -> String {
    return Equals(format, TimeFormat.TwelveHour) ? TimeStamp.ToTwelveHourString(time) : TimeStamp.ToTwentyFourHourString(time);
  }
}