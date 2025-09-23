module DialogueHistory.UI


public class SavedFilterButtonController extends inkLogicController {
  protected let m_containerRef: inkWidgetRef;

  protected let m_toggled: Bool;

  protected let m_hovered: Bool;

  protected let m_tooltipsManager: wref<gameuiTooltipsManager>;

  protected cb func OnInitialize() -> Bool {
    this.RegisterToCallback(n"OnHoverOut", this, n"OnHoverOut");
    this.RegisterToCallback(n"OnHoverOver", this, n"OnHoverOver");
    this.RegisterToCallback(n"OnRelease", this, n"OnClicked");
  }

  public final func Setup(tooltipsManager: wref<gameuiTooltipsManager>) -> Void {
    this.m_tooltipsManager = tooltipsManager;
  }

  protected cb func OnHoverOut(event: ref<inkPointerEvent>) -> Bool {
    if IsDefined(this.m_tooltipsManager) {
      this.m_tooltipsManager.HideTooltips();
    };

    this.m_hovered = false;
    this.UpdateState();
  }

  protected cb func OnHoverOver(event: ref<inkPointerEvent>) -> Bool {
    if IsDefined(this.m_tooltipsManager) {
      this.m_tooltipsManager.ShowTooltipAtWidget(0, event.GetCurrentTarget(), FilterTooltipData.Initialize(this), gameuiETooltipPlacement.RightCenter);
    };

    this.m_hovered = true;
    this.UpdateState();
  }

  protected cb func OnClicked(event: ref<inkPointerEvent>) -> Bool {
    if !event.IsAction(n"click") {
      return false;
    }

    this.m_toggled = !this.m_toggled;

    this.PlaySound(n"Button", n"OnPress");
    this.UpdateState();
    this.QueueEvent(SavedFilterButtonClickedEvent.Create(this.m_toggled));
  }

  protected final func UpdateState() -> Void {
    if this.m_hovered {
      inkWidgetRef.SetState(this.m_containerRef, n"Hover");
    } else if this.m_toggled {
      inkWidgetRef.SetState(this.m_containerRef, n"Active");
    } else {
      inkWidgetRef.SetState(this.m_containerRef, n"Default");
    }
  }
}

class FilterTooltipData extends MessageTooltipData {
  public static final func Initialize(controller: wref<SavedFilterButtonController>) -> ref<FilterTooltipData> {
    let data: ref<FilterTooltipData> = new FilterTooltipData();
    data.Title = GetLocalizedTextByKey(n"DialogueHistory-Filter-Saved");

    return data;
  }
}