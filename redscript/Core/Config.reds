module DialogueHistory.Core

import DialogueHistory.Utils.{Color, TimeFormat}

public class Config extends ScriptableService {
  // ---
  // GENERAL
  // ---

  @runtimeProperty("ModSettings.mod", "Dialogue History")
  @runtimeProperty("ModSettings.category", "DialogueHistory-Config-General")
  @runtimeProperty("ModSettings.category.order", "1")
  @runtimeProperty("ModSettings.displayName", "DialogueHistory-Config-General-InputHint-DisplayName")
  @runtimeProperty("ModSettings.description", "DialogueHistory-Config-General-InputHint-Description")
  public let showInputHint: Bool = true;

  @runtimeProperty("ModSettings.mod", "Dialogue History")
  @runtimeProperty("ModSettings.category", "DialogueHistory-Config-General")
  @runtimeProperty("ModSettings.category.order", "1")
  @runtimeProperty("ModSettings.displayName", "DialogueHistory-Config-General-Lifecycle-DisplayName")
  @runtimeProperty("ModSettings.description", "DialogueHistory-Config-General-Lifecycle-Description")
  public let lifecycle: Bool = true;

  @runtimeProperty("ModSettings.mod", "Dialogue History")
  @runtimeProperty("ModSettings.category", "DialogueHistory-Config-General")
  @runtimeProperty("ModSettings.category.order", "1")
  @runtimeProperty("ModSettings.displayName", "DialogueHistory-Config-General-LifecycleDays-DisplayName")
  @runtimeProperty("ModSettings.description", "DialogueHistory-Config-General-LifecycleDays-Description")
  @runtimeProperty("ModSettings.dependency", "lifecycle")
  @runtimeProperty("ModSettings.min", "1")
  @runtimeProperty("ModSettings.max", "365")
  @runtimeProperty("ModSettings.step", "1")
  public let lifecycleDays: Int32 = 7;

  @runtimeProperty("ModSettings.mod", "Dialogue History")
  @runtimeProperty("ModSettings.category", "DialogueHistory-Config-General")
  @runtimeProperty("ModSettings.category.order", "1")
  @runtimeProperty("ModSettings.displayName", "DialogueHistory-Config-General-Persistent-DisplayName")
  @runtimeProperty("ModSettings.description", "DialogueHistory-Config-General-Persistent-Description")
  public let ignorePersistentLines: Bool = true;

  // ---
  // INTERFACE
  // ---

  @runtimeProperty("ModSettings.mod", "Dialogue History")
  @runtimeProperty("ModSettings.category", "DialogueHistory-Config-Interface")
  @runtimeProperty("ModSettings.category.order", "2")
  @runtimeProperty("ModSettings.displayName", "DialogueHistory-Config-Interface-Animate-DisplayName")
  @runtimeProperty("ModSettings.description", "DialogueHistory-Config-Interface-Animate-Description")
  public let animatePopup: Bool = true;

  @runtimeProperty("ModSettings.mod", "Dialogue History")
  @runtimeProperty("ModSettings.category", "DialogueHistory-Config-Interface")
  @runtimeProperty("ModSettings.category.order", "2")
  @runtimeProperty("ModSettings.displayName", "DialogueHistory-Config-Interface-ShowTime-DisplayName")
  @runtimeProperty("ModSettings.description", "DialogueHistory-Config-Interface-ShowTime-Description")
  public let showTime: Bool = true;

  @runtimeProperty("ModSettings.mod", "Dialogue History")
  @runtimeProperty("ModSettings.category", "DialogueHistory-Config-Interface")
  @runtimeProperty("ModSettings.category.order", "2")
  @runtimeProperty("ModSettings.displayName", "DialogueHistory-Config-Interface-TimeFormat-DisplayName")
  @runtimeProperty("ModSettings.description", "DialogueHistory-Config-Interface-TimeFormat-Description")
  @runtimeProperty("ModSettings.dependency", "showTime")
  @runtimeProperty("ModSettings.displayValues.TwelveHour", "DialogueHistory-TimeFormat-TwelveHour")
  @runtimeProperty("ModSettings.displayValues.TwentyFourHour", "DialogueHistory-TimeFormat-TwentyFourHour")
  public let timeFormat: TimeFormat = TimeFormat.TwelveHour;

  @runtimeProperty("ModSettings.mod", "Dialogue History")
  @runtimeProperty("ModSettings.category", "DialogueHistory-Config-Interface")
  @runtimeProperty("ModSettings.category.order", "2")
  @runtimeProperty("ModSettings.displayName", "DialogueHistory-Config-Interface-Height-DisplayName")
  @runtimeProperty("ModSettings.description", "DialogueHistory-Config-Interface-Height-Description")
  @runtimeProperty("ModSettings.min", "0")
  @runtimeProperty("ModSettings.max", "5000.0")
  @runtimeProperty("ModSettings.step", "1.0")
  public let popupHeight: Float = 1500.0;

  @runtimeProperty("ModSettings.mod", "Dialogue History")
  @runtimeProperty("ModSettings.category", "DialogueHistory-Config-Interface")
  @runtimeProperty("ModSettings.category.order", "2")
  @runtimeProperty("ModSettings.displayName", "DialogueHistory-Config-Interface-Width-DisplayName")
  @runtimeProperty("ModSettings.description", "DialogueHistory-Config-Interface-Width-Description")
  @runtimeProperty("ModSettings.min", "0")
  @runtimeProperty("ModSettings.max", "5000.0")
  @runtimeProperty("ModSettings.step", "1.0")
  public let popupWidth: Float = 2300.0;

  @runtimeProperty("ModSettings.mod", "Dialogue History")
  @runtimeProperty("ModSettings.category", "DialogueHistory-Config-Interface")
  @runtimeProperty("ModSettings.category.order", "2")
  @runtimeProperty("ModSettings.displayName", "DialogueHistory-Config-Interface-FontSize-DisplayName")
  @runtimeProperty("ModSettings.description", "DialogueHistory-Config-Interface-FontSize-Description")
  @runtimeProperty("ModSettings.min", "1")
  @runtimeProperty("ModSettings.max", "100")
  @runtimeProperty("ModSettings.step", "1")
  public let fontSize: Int32 = 30;

  @runtimeProperty("ModSettings.mod", "Dialogue History")
  @runtimeProperty("ModSettings.category", "DialogueHistory-Config-Interface")
  @runtimeProperty("ModSettings.category.order", "2")
  @runtimeProperty("ModSettings.displayName", "DialogueHistory-Config-Interface-Margin-DisplayName")
  @runtimeProperty("ModSettings.description", "DialogueHistory-Config-Interface-Margin-Description")
  @runtimeProperty("ModSettings.min", "0.0")
  @runtimeProperty("ModSettings.max", "50.0")
  @runtimeProperty("ModSettings.step", "0.1")
  public let margin: Float = 40.0;

  @runtimeProperty("ModSettings.mod", "Dialogue History")
  @runtimeProperty("ModSettings.category", "DialogueHistory-Config-Interface")
  @runtimeProperty("ModSettings.category.order", "2")
  @runtimeProperty("ModSettings.displayName", "DialogueHistory-Config-Interface-FrameColor-DisplayName")
  @runtimeProperty("ModSettings.description", "DialogueHistory-Config-Interface-FrameColor-Description")
  @runtimeProperty("ModSettings.displayValues.White", "DialogueHistory-Color-White")
  @runtimeProperty("ModSettings.displayValues.Red", "DialogueHistory-Color-Red")
  @runtimeProperty("ModSettings.displayValues.ActiveRed", "DialogueHistory-Color-ActiveRed")
  @runtimeProperty("ModSettings.displayValues.MildRed", "DialogueHistory-Color-MildRed")
  @runtimeProperty("ModSettings.displayValues.DarkRed", "DialogueHistory-Color-DarkRed")
  @runtimeProperty("ModSettings.displayValues.FaintRed", "DialogueHistory-Color-FaintRed")
  @runtimeProperty("ModSettings.displayValues.Blue", "DialogueHistory-Color-Blue")
  @runtimeProperty("ModSettings.displayValues.ActiveBlue", "DialogueHistory-Color-ActiveBlue")
  @runtimeProperty("ModSettings.displayValues.MildBlue", "DialogueHistory-Color-MildBlue")
  @runtimeProperty("ModSettings.displayValues.DarkBlue", "DialogueHistory-Color-DarkBlue")
  @runtimeProperty("ModSettings.displayValues.FaintBlue", "DialogueHistory-Color-FaintBlue")
  @runtimeProperty("ModSettings.displayValues.MediumBlue", "DialogueHistory-Color-MediumBlue")
  @runtimeProperty("ModSettings.displayValues.Yellow", "DialogueHistory-Color-Yellow")
  @runtimeProperty("ModSettings.displayValues.ActiveYellow", "DialogueHistory-Color-ActiveYellow")
  @runtimeProperty("ModSettings.displayValues.MildYellow", "DialogueHistory-Color-MildYellow")
  @runtimeProperty("ModSettings.displayValues.Gold", "DialogueHistory-Color-Gold")
  @runtimeProperty("ModSettings.displayValues.FaintYellow", "DialogueHistory-Color-FaintYellow")
  @runtimeProperty("ModSettings.displayValues.DarkGold", "DialogueHistory-Color-DarkGold")
  @runtimeProperty("ModSettings.displayValues.Green", "DialogueHistory-Color-Green")
  @runtimeProperty("ModSettings.displayValues.MildGreen", "DialogueHistory-Color-MildGreen")
  @runtimeProperty("ModSettings.displayValues.ActiveGreen", "DialogueHistory-Color-ActiveGreen")
  @runtimeProperty("ModSettings.displayValues.DarkGreen", "DialogueHistory-Color-DarkGreen")
  @runtimeProperty("ModSettings.displayValues.Orange", "DialogueHistory-Color-Orange")
  @runtimeProperty("ModSettings.displayValues.Grey", "DialogueHistory-Color-Grey")
  @runtimeProperty("ModSettings.displayValues.DarkGrey", "DialogueHistory-Color-DarkGrey")
  public let frameColor: Color = Color.MildRed;

  @runtimeProperty("ModSettings.mod", "Dialogue History")
  @runtimeProperty("ModSettings.category", "DialogueHistory-Config-Interface")
  @runtimeProperty("ModSettings.category.order", "2")
  @runtimeProperty("ModSettings.displayName", "DialogueHistory-Config-Interface-TimeColor-DisplayName")
  @runtimeProperty("ModSettings.description", "DialogueHistory-Config-Interface-TimeColor-Description")
  @runtimeProperty("ModSettings.dependency", "showTime")
  @runtimeProperty("ModSettings.displayValues.White", "DialogueHistory-Color-White")
  @runtimeProperty("ModSettings.displayValues.Red", "DialogueHistory-Color-Red")
  @runtimeProperty("ModSettings.displayValues.ActiveRed", "DialogueHistory-Color-ActiveRed")
  @runtimeProperty("ModSettings.displayValues.MildRed", "DialogueHistory-Color-MildRed")
  @runtimeProperty("ModSettings.displayValues.DarkRed", "DialogueHistory-Color-DarkRed")
  @runtimeProperty("ModSettings.displayValues.FaintRed", "DialogueHistory-Color-FaintRed")
  @runtimeProperty("ModSettings.displayValues.Blue", "DialogueHistory-Color-Blue")
  @runtimeProperty("ModSettings.displayValues.ActiveBlue", "DialogueHistory-Color-ActiveBlue")
  @runtimeProperty("ModSettings.displayValues.MildBlue", "DialogueHistory-Color-MildBlue")
  @runtimeProperty("ModSettings.displayValues.DarkBlue", "DialogueHistory-Color-DarkBlue")
  @runtimeProperty("ModSettings.displayValues.FaintBlue", "DialogueHistory-Color-FaintBlue")
  @runtimeProperty("ModSettings.displayValues.MediumBlue", "DialogueHistory-Color-MediumBlue")
  @runtimeProperty("ModSettings.displayValues.Yellow", "DialogueHistory-Color-Yellow")
  @runtimeProperty("ModSettings.displayValues.ActiveYellow", "DialogueHistory-Color-ActiveYellow")
  @runtimeProperty("ModSettings.displayValues.MildYellow", "DialogueHistory-Color-MildYellow")
  @runtimeProperty("ModSettings.displayValues.Gold", "DialogueHistory-Color-Gold")
  @runtimeProperty("ModSettings.displayValues.FaintYellow", "DialogueHistory-Color-FaintYellow")
  @runtimeProperty("ModSettings.displayValues.DarkGold", "DialogueHistory-Color-DarkGold")
  @runtimeProperty("ModSettings.displayValues.Green", "DialogueHistory-Color-Green")
  @runtimeProperty("ModSettings.displayValues.MildGreen", "DialogueHistory-Color-MildGreen")
  @runtimeProperty("ModSettings.displayValues.ActiveGreen", "DialogueHistory-Color-ActiveGreen")
  @runtimeProperty("ModSettings.displayValues.DarkGreen", "DialogueHistory-Color-DarkGreen")
  @runtimeProperty("ModSettings.displayValues.Orange", "DialogueHistory-Color-Orange")
  @runtimeProperty("ModSettings.displayValues.Grey", "DialogueHistory-Color-Grey")
  @runtimeProperty("ModSettings.displayValues.DarkGrey", "DialogueHistory-Color-DarkGrey")
  public let timeColor: Color = Color.Grey;

  @runtimeProperty("ModSettings.mod", "Dialogue History")
  @runtimeProperty("ModSettings.category", "DialogueHistory-Config-Interface")
  @runtimeProperty("ModSettings.category.order", "2")
  @runtimeProperty("ModSettings.displayName", "DialogueHistory-Config-Interface-VNameColor-DisplayName")
  @runtimeProperty("ModSettings.description", "DialogueHistory-Config-Interface-VNameColor-Description")
  @runtimeProperty("ModSettings.displayValues.White", "DialogueHistory-Color-White")
  @runtimeProperty("ModSettings.displayValues.Red", "DialogueHistory-Color-Red")
  @runtimeProperty("ModSettings.displayValues.ActiveRed", "DialogueHistory-Color-ActiveRed")
  @runtimeProperty("ModSettings.displayValues.MildRed", "DialogueHistory-Color-MildRed")
  @runtimeProperty("ModSettings.displayValues.DarkRed", "DialogueHistory-Color-DarkRed")
  @runtimeProperty("ModSettings.displayValues.FaintRed", "DialogueHistory-Color-FaintRed")
  @runtimeProperty("ModSettings.displayValues.Blue", "DialogueHistory-Color-Blue")
  @runtimeProperty("ModSettings.displayValues.ActiveBlue", "DialogueHistory-Color-ActiveBlue")
  @runtimeProperty("ModSettings.displayValues.MildBlue", "DialogueHistory-Color-MildBlue")
  @runtimeProperty("ModSettings.displayValues.DarkBlue", "DialogueHistory-Color-DarkBlue")
  @runtimeProperty("ModSettings.displayValues.FaintBlue", "DialogueHistory-Color-FaintBlue")
  @runtimeProperty("ModSettings.displayValues.MediumBlue", "DialogueHistory-Color-MediumBlue")
  @runtimeProperty("ModSettings.displayValues.Yellow", "DialogueHistory-Color-Yellow")
  @runtimeProperty("ModSettings.displayValues.ActiveYellow", "DialogueHistory-Color-ActiveYellow")
  @runtimeProperty("ModSettings.displayValues.MildYellow", "DialogueHistory-Color-MildYellow")
  @runtimeProperty("ModSettings.displayValues.Gold", "DialogueHistory-Color-Gold")
  @runtimeProperty("ModSettings.displayValues.FaintYellow", "DialogueHistory-Color-FaintYellow")
  @runtimeProperty("ModSettings.displayValues.DarkGold", "DialogueHistory-Color-DarkGold")
  @runtimeProperty("ModSettings.displayValues.Green", "DialogueHistory-Color-Green")
  @runtimeProperty("ModSettings.displayValues.MildGreen", "DialogueHistory-Color-MildGreen")
  @runtimeProperty("ModSettings.displayValues.ActiveGreen", "DialogueHistory-Color-ActiveGreen")
  @runtimeProperty("ModSettings.displayValues.DarkGreen", "DialogueHistory-Color-DarkGreen")
  @runtimeProperty("ModSettings.displayValues.Orange", "DialogueHistory-Color-Orange")
  @runtimeProperty("ModSettings.displayValues.Grey", "DialogueHistory-Color-Grey")
  @runtimeProperty("ModSettings.displayValues.DarkGrey", "DialogueHistory-Color-DarkGrey")
  public let vSpeakerColor: Color = Color.Red;

  @runtimeProperty("ModSettings.mod", "Dialogue History")
  @runtimeProperty("ModSettings.category", "DialogueHistory-Config-Interface")
  @runtimeProperty("ModSettings.category.order", "2")
  @runtimeProperty("ModSettings.displayName", "DialogueHistory-Config-Interface-OverheadNameColor-DisplayName")
  @runtimeProperty("ModSettings.description", "DialogueHistory-Config-Interface-OverheadNameColor-Description")
  @runtimeProperty("ModSettings.displayValues.White", "DialogueHistory-Color-White")
  @runtimeProperty("ModSettings.displayValues.Red", "DialogueHistory-Color-Red")
  @runtimeProperty("ModSettings.displayValues.ActiveRed", "DialogueHistory-Color-ActiveRed")
  @runtimeProperty("ModSettings.displayValues.MildRed", "DialogueHistory-Color-MildRed")
  @runtimeProperty("ModSettings.displayValues.DarkRed", "DialogueHistory-Color-DarkRed")
  @runtimeProperty("ModSettings.displayValues.FaintRed", "DialogueHistory-Color-FaintRed")
  @runtimeProperty("ModSettings.displayValues.Blue", "DialogueHistory-Color-Blue")
  @runtimeProperty("ModSettings.displayValues.ActiveBlue", "DialogueHistory-Color-ActiveBlue")
  @runtimeProperty("ModSettings.displayValues.MildBlue", "DialogueHistory-Color-MildBlue")
  @runtimeProperty("ModSettings.displayValues.DarkBlue", "DialogueHistory-Color-DarkBlue")
  @runtimeProperty("ModSettings.displayValues.FaintBlue", "DialogueHistory-Color-FaintBlue")
  @runtimeProperty("ModSettings.displayValues.MediumBlue", "DialogueHistory-Color-MediumBlue")
  @runtimeProperty("ModSettings.displayValues.Yellow", "DialogueHistory-Color-Yellow")
  @runtimeProperty("ModSettings.displayValues.ActiveYellow", "DialogueHistory-Color-ActiveYellow")
  @runtimeProperty("ModSettings.displayValues.MildYellow", "DialogueHistory-Color-MildYellow")
  @runtimeProperty("ModSettings.displayValues.Gold", "DialogueHistory-Color-Gold")
  @runtimeProperty("ModSettings.displayValues.FaintYellow", "DialogueHistory-Color-FaintYellow")
  @runtimeProperty("ModSettings.displayValues.DarkGold", "DialogueHistory-Color-DarkGold")
  @runtimeProperty("ModSettings.displayValues.Green", "DialogueHistory-Color-Green")
  @runtimeProperty("ModSettings.displayValues.MildGreen", "DialogueHistory-Color-MildGreen")
  @runtimeProperty("ModSettings.displayValues.ActiveGreen", "DialogueHistory-Color-ActiveGreen")
  @runtimeProperty("ModSettings.displayValues.DarkGreen", "DialogueHistory-Color-DarkGreen")
  @runtimeProperty("ModSettings.displayValues.Orange", "DialogueHistory-Color-Orange")
  @runtimeProperty("ModSettings.displayValues.Grey", "DialogueHistory-Color-Grey")
  @runtimeProperty("ModSettings.displayValues.DarkGrey", "DialogueHistory-Color-DarkGrey")
  public let overheadColor: Color = Color.Blue;

  @runtimeProperty("ModSettings.mod", "Dialogue History")
  @runtimeProperty("ModSettings.category", "DialogueHistory-Config-Interface")
  @runtimeProperty("ModSettings.category.order", "2")
  @runtimeProperty("ModSettings.displayName", "DialogueHistory-Config-Interface-RadioNameColor-DisplayName")
  @runtimeProperty("ModSettings.description", "DialogueHistory-Config-Interface-RadioNameColor-Description")
  @runtimeProperty("ModSettings.displayValues.White", "DialogueHistory-Color-White")
  @runtimeProperty("ModSettings.displayValues.Red", "DialogueHistory-Color-Red")
  @runtimeProperty("ModSettings.displayValues.ActiveRed", "DialogueHistory-Color-ActiveRed")
  @runtimeProperty("ModSettings.displayValues.MildRed", "DialogueHistory-Color-MildRed")
  @runtimeProperty("ModSettings.displayValues.DarkRed", "DialogueHistory-Color-DarkRed")
  @runtimeProperty("ModSettings.displayValues.FaintRed", "DialogueHistory-Color-FaintRed")
  @runtimeProperty("ModSettings.displayValues.Blue", "DialogueHistory-Color-Blue")
  @runtimeProperty("ModSettings.displayValues.ActiveBlue", "DialogueHistory-Color-ActiveBlue")
  @runtimeProperty("ModSettings.displayValues.MildBlue", "DialogueHistory-Color-MildBlue")
  @runtimeProperty("ModSettings.displayValues.DarkBlue", "DialogueHistory-Color-DarkBlue")
  @runtimeProperty("ModSettings.displayValues.FaintBlue", "DialogueHistory-Color-FaintBlue")
  @runtimeProperty("ModSettings.displayValues.MediumBlue", "DialogueHistory-Color-MediumBlue")
  @runtimeProperty("ModSettings.displayValues.Yellow", "DialogueHistory-Color-Yellow")
  @runtimeProperty("ModSettings.displayValues.ActiveYellow", "DialogueHistory-Color-ActiveYellow")
  @runtimeProperty("ModSettings.displayValues.MildYellow", "DialogueHistory-Color-MildYellow")
  @runtimeProperty("ModSettings.displayValues.Gold", "DialogueHistory-Color-Gold")
  @runtimeProperty("ModSettings.displayValues.FaintYellow", "DialogueHistory-Color-FaintYellow")
  @runtimeProperty("ModSettings.displayValues.DarkGold", "DialogueHistory-Color-DarkGold")
  @runtimeProperty("ModSettings.displayValues.Green", "DialogueHistory-Color-Green")
  @runtimeProperty("ModSettings.displayValues.MildGreen", "DialogueHistory-Color-MildGreen")
  @runtimeProperty("ModSettings.displayValues.ActiveGreen", "DialogueHistory-Color-ActiveGreen")
  @runtimeProperty("ModSettings.displayValues.DarkGreen", "DialogueHistory-Color-DarkGreen")
  @runtimeProperty("ModSettings.displayValues.Orange", "DialogueHistory-Color-Orange")
  @runtimeProperty("ModSettings.displayValues.Grey", "DialogueHistory-Color-Grey")
  @runtimeProperty("ModSettings.displayValues.DarkGrey", "DialogueHistory-Color-DarkGrey")
  public let radioColor: Color = Color.Green;

  @runtimeProperty("ModSettings.mod", "Dialogue History")
  @runtimeProperty("ModSettings.category", "DialogueHistory-Config-Interface")
  @runtimeProperty("ModSettings.category.order", "2")
  @runtimeProperty("ModSettings.displayName", "DialogueHistory-Config-Interface-GlobalTVNameColor-DisplayName")
  @runtimeProperty("ModSettings.description", "DialogueHistory-Config-Interface-GlobalTVNameColor-Description")
  @runtimeProperty("ModSettings.displayValues.White", "DialogueHistory-Color-White")
  @runtimeProperty("ModSettings.displayValues.Red", "DialogueHistory-Color-Red")
  @runtimeProperty("ModSettings.displayValues.ActiveRed", "DialogueHistory-Color-ActiveRed")
  @runtimeProperty("ModSettings.displayValues.MildRed", "DialogueHistory-Color-MildRed")
  @runtimeProperty("ModSettings.displayValues.DarkRed", "DialogueHistory-Color-DarkRed")
  @runtimeProperty("ModSettings.displayValues.FaintRed", "DialogueHistory-Color-FaintRed")
  @runtimeProperty("ModSettings.displayValues.Blue", "DialogueHistory-Color-Blue")
  @runtimeProperty("ModSettings.displayValues.ActiveBlue", "DialogueHistory-Color-ActiveBlue")
  @runtimeProperty("ModSettings.displayValues.MildBlue", "DialogueHistory-Color-MildBlue")
  @runtimeProperty("ModSettings.displayValues.DarkBlue", "DialogueHistory-Color-DarkBlue")
  @runtimeProperty("ModSettings.displayValues.FaintBlue", "DialogueHistory-Color-FaintBlue")
  @runtimeProperty("ModSettings.displayValues.MediumBlue", "DialogueHistory-Color-MediumBlue")
  @runtimeProperty("ModSettings.displayValues.Yellow", "DialogueHistory-Color-Yellow")
  @runtimeProperty("ModSettings.displayValues.ActiveYellow", "DialogueHistory-Color-ActiveYellow")
  @runtimeProperty("ModSettings.displayValues.MildYellow", "DialogueHistory-Color-MildYellow")
  @runtimeProperty("ModSettings.displayValues.Gold", "DialogueHistory-Color-Gold")
  @runtimeProperty("ModSettings.displayValues.FaintYellow", "DialogueHistory-Color-FaintYellow")
  @runtimeProperty("ModSettings.displayValues.DarkGold", "DialogueHistory-Color-DarkGold")
  @runtimeProperty("ModSettings.displayValues.Green", "DialogueHistory-Color-Green")
  @runtimeProperty("ModSettings.displayValues.MildGreen", "DialogueHistory-Color-MildGreen")
  @runtimeProperty("ModSettings.displayValues.ActiveGreen", "DialogueHistory-Color-ActiveGreen")
  @runtimeProperty("ModSettings.displayValues.DarkGreen", "DialogueHistory-Color-DarkGreen")
  @runtimeProperty("ModSettings.displayValues.Orange", "DialogueHistory-Color-Orange")
  @runtimeProperty("ModSettings.displayValues.Grey", "DialogueHistory-Color-Grey")
  @runtimeProperty("ModSettings.displayValues.DarkGrey", "DialogueHistory-Color-DarkGrey")
  public let globalTVColor: Color = Color.Yellow;

  @runtimeProperty("ModSettings.mod", "Dialogue History")
  @runtimeProperty("ModSettings.category", "DialogueHistory-Config-Interface")
  @runtimeProperty("ModSettings.category.order", "2")
  @runtimeProperty("ModSettings.displayName", "DialogueHistory-Config-Interface-DefaultNameColor-DisplayName")
  @runtimeProperty("ModSettings.description", "DialogueHistory-Config-Interface-DefaultNameColor-Description")
  @runtimeProperty("ModSettings.displayValues.White", "DialogueHistory-Color-White")
  @runtimeProperty("ModSettings.displayValues.Red", "DialogueHistory-Color-Red")
  @runtimeProperty("ModSettings.displayValues.ActiveRed", "DialogueHistory-Color-ActiveRed")
  @runtimeProperty("ModSettings.displayValues.MildRed", "DialogueHistory-Color-MildRed")
  @runtimeProperty("ModSettings.displayValues.DarkRed", "DialogueHistory-Color-DarkRed")
  @runtimeProperty("ModSettings.displayValues.FaintRed", "DialogueHistory-Color-FaintRed")
  @runtimeProperty("ModSettings.displayValues.Blue", "DialogueHistory-Color-Blue")
  @runtimeProperty("ModSettings.displayValues.ActiveBlue", "DialogueHistory-Color-ActiveBlue")
  @runtimeProperty("ModSettings.displayValues.MildBlue", "DialogueHistory-Color-MildBlue")
  @runtimeProperty("ModSettings.displayValues.DarkBlue", "DialogueHistory-Color-DarkBlue")
  @runtimeProperty("ModSettings.displayValues.FaintBlue", "DialogueHistory-Color-FaintBlue")
  @runtimeProperty("ModSettings.displayValues.MediumBlue", "DialogueHistory-Color-MediumBlue")
  @runtimeProperty("ModSettings.displayValues.Yellow", "DialogueHistory-Color-Yellow")
  @runtimeProperty("ModSettings.displayValues.ActiveYellow", "DialogueHistory-Color-ActiveYellow")
  @runtimeProperty("ModSettings.displayValues.MildYellow", "DialogueHistory-Color-MildYellow")
  @runtimeProperty("ModSettings.displayValues.Gold", "DialogueHistory-Color-Gold")
  @runtimeProperty("ModSettings.displayValues.FaintYellow", "DialogueHistory-Color-FaintYellow")
  @runtimeProperty("ModSettings.displayValues.DarkGold", "DialogueHistory-Color-DarkGold")
  @runtimeProperty("ModSettings.displayValues.Green", "DialogueHistory-Color-Green")
  @runtimeProperty("ModSettings.displayValues.MildGreen", "DialogueHistory-Color-MildGreen")
  @runtimeProperty("ModSettings.displayValues.ActiveGreen", "DialogueHistory-Color-ActiveGreen")
  @runtimeProperty("ModSettings.displayValues.DarkGreen", "DialogueHistory-Color-DarkGreen")
  @runtimeProperty("ModSettings.displayValues.Orange", "DialogueHistory-Color-Orange")
  @runtimeProperty("ModSettings.displayValues.Grey", "DialogueHistory-Color-Grey")
  @runtimeProperty("ModSettings.displayValues.DarkGrey", "DialogueHistory-Color-DarkGrey")
  public let speakerColor: Color = Color.Red;

  @runtimeProperty("ModSettings.mod", "Dialogue History")
  @runtimeProperty("ModSettings.category", "DialogueHistory-Config-Interface")
  @runtimeProperty("ModSettings.category.order", "2")
  @runtimeProperty("ModSettings.displayName", "DialogueHistory-Config-Interface-TextColor-DisplayName")
  @runtimeProperty("ModSettings.description", "DialogueHistory-Config-Interface-TextColor-Description")
  @runtimeProperty("ModSettings.displayValues.White", "DialogueHistory-Color-White")
  @runtimeProperty("ModSettings.displayValues.Red", "DialogueHistory-Color-Red")
  @runtimeProperty("ModSettings.displayValues.ActiveRed", "DialogueHistory-Color-ActiveRed")
  @runtimeProperty("ModSettings.displayValues.MildRed", "DialogueHistory-Color-MildRed")
  @runtimeProperty("ModSettings.displayValues.DarkRed", "DialogueHistory-Color-DarkRed")
  @runtimeProperty("ModSettings.displayValues.FaintRed", "DialogueHistory-Color-FaintRed")
  @runtimeProperty("ModSettings.displayValues.Blue", "DialogueHistory-Color-Blue")
  @runtimeProperty("ModSettings.displayValues.ActiveBlue", "DialogueHistory-Color-ActiveBlue")
  @runtimeProperty("ModSettings.displayValues.MildBlue", "DialogueHistory-Color-MildBlue")
  @runtimeProperty("ModSettings.displayValues.DarkBlue", "DialogueHistory-Color-DarkBlue")
  @runtimeProperty("ModSettings.displayValues.FaintBlue", "DialogueHistory-Color-FaintBlue")
  @runtimeProperty("ModSettings.displayValues.MediumBlue", "DialogueHistory-Color-MediumBlue")
  @runtimeProperty("ModSettings.displayValues.Yellow", "DialogueHistory-Color-Yellow")
  @runtimeProperty("ModSettings.displayValues.ActiveYellow", "DialogueHistory-Color-ActiveYellow")
  @runtimeProperty("ModSettings.displayValues.MildYellow", "DialogueHistory-Color-MildYellow")
  @runtimeProperty("ModSettings.displayValues.Gold", "DialogueHistory-Color-Gold")
  @runtimeProperty("ModSettings.displayValues.FaintYellow", "DialogueHistory-Color-FaintYellow")
  @runtimeProperty("ModSettings.displayValues.DarkGold", "DialogueHistory-Color-DarkGold")
  @runtimeProperty("ModSettings.displayValues.Green", "DialogueHistory-Color-Green")
  @runtimeProperty("ModSettings.displayValues.MildGreen", "DialogueHistory-Color-MildGreen")
  @runtimeProperty("ModSettings.displayValues.ActiveGreen", "DialogueHistory-Color-ActiveGreen")
  @runtimeProperty("ModSettings.displayValues.DarkGreen", "DialogueHistory-Color-DarkGreen")
  @runtimeProperty("ModSettings.displayValues.Orange", "DialogueHistory-Color-Orange")
  @runtimeProperty("ModSettings.displayValues.Grey", "DialogueHistory-Color-Grey")
  @runtimeProperty("ModSettings.displayValues.DarkGrey", "DialogueHistory-Color-DarkGrey")
  public let textColor: Color = Color.White;

  private cb func OnLoad() -> Void {
    ModSettings.RegisterListenerToClass(this);
  }

  private cb func OnReload() -> Void {
    ModSettings.RegisterListenerToClass(this);
  }

  private cb func OnUninitialize() -> Void {
    ModSettings.UnregisterListenerToClass(this);
  }

  public final static func Get() -> ref<Config> {
    return GameInstance.GetScriptableServiceContainer().GetService(n"DialogueHistory.Core.Config") as Config;
  }
}
