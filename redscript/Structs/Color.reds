module DialogueHistory.Structs


public enum Color {
  White = 0,
  Red = 1,
  ActiveRed = 2,
  MildRed = 3,
  DarkRed = 4,
  FaintRed = 5,
  Blue = 6,
  ActiveBlue = 7,
  MildBlue = 8,
  DarkBlue = 9,
  FaintBlue = 10,
  MediumBlue = 11,
  Yellow = 12,
  ActiveYellow = 13,
  MildYellow = 14,
  Gold = 15,
  FaintYellow = 16,
  DarkGold = 17,
  Green = 18,
  MildGreen = 19,
  ActiveGreen = 20,
  DarkGreen = 21,
  Orange = 22,
  Grey = 23,
  DarkGrey = 24,
}

public func ColorToName(color: Color) -> CName {
  switch color {
    case Color.White:
      return n"MainColors.White";
    case Color.Red:
      return n"MainColors.Red";
    case Color.ActiveRed:
      return n"MainColors.ActiveRed";
    case Color.MildRed:
      return n"MainColors.MildRed";
    case Color.DarkRed:
      return n"MainColors.DarkRed";
    case Color.FaintRed:
      return n"MainColors.FaintRed";
    case Color.Blue:
      return n"MainColors.Blue";
    case Color.ActiveBlue:
      return n"MainColors.ActiveBlue";
    case Color.MildBlue:
      return n"MainColors.MildBlue";
    case Color.DarkBlue:
      return n"MainColors.DarkBlue";
    case Color.FaintBlue:
      return n"MainColors.FaintBlue";
    case Color.MediumBlue:
      return n"MainColors.MediumBlue";
    case Color.Yellow:
      return n"MainColors.Yellow";
    case Color.ActiveYellow:
      return n"MainColors.ActiveYellow";
    case Color.MildYellow:
      return n"MainColors.MildYellow";
    case Color.Gold:
      return n"MainColors.Gold";
    case Color.FaintYellow:
      return n"MainColors.FaintYellow";
    case Color.DarkGold:
      return n"MainColors.DarkGold";
    case Color.Green:
      return n"MainColors.Green";
    case Color.MildGreen:
      return n"MainColors.MildGreen";
    case Color.ActiveGreen:
      return n"MainColors.ActiveGreen";
    case Color.DarkGreen:
      return n"MainColors.DarkGreen";
    case Color.Orange:
      return n"MainColors.Orange";
    case Color.Grey:
      return n"MainColors.Grey";
    case Color.DarkGrey:
      return n"MainColors.DarkGrey";

    default:
      return n"MainColors.White";
  }
}