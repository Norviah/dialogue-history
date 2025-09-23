module DialogueHistory.UI

import Codeware.UI.{inkCustomController, HubTextInput}


public class SearchInput extends inkCustomController {
  protected let m_root: wref<inkHorizontalPanel>;

  protected let m_searchInput: wref<HubTextInput>;

  protected let m_delaySystem: wref<DelaySystem>;

  protected let m_searchEventCallback: ref<DelayCallback>;

  protected let m_searchEventDelayID: DelayID;

  protected cb func OnCreate() {
    let root = new inkHorizontalPanel();
    root.SetAnchor(inkEAnchor.TopRight);
    root.SetAnchorPoint(1.0, 0.0);

    let input = HubTextInput.Create();
    input.SetLetterCase(textLetterCase.UpperCase);
    input.SetDefaultText(GetLocalizedText("LocKey#48662"));
    input.RegisterToCallback(n"OnInput", this, n"OnSearchInput");
    input.SetWidth(400.0);
    input.Reparent(root);

    input.m_root.SetHeight(74.0);

    this.m_root = root;
    this.m_searchInput = input;

    this.SetRootWidget(root);
  }

  protected cb func OnInitialize() {
    this.m_delaySystem = GameInstance.GetDelaySystem(this.GetGame());
    this.m_searchEventCallback = SearchInputCallback.Create(this);

    this.RegisterToGlobalInputCallback(n"OnPostOnRelease", this, n"OnGlobalInput");
  }

  protected cb func OnUninitialize() {
    this.UnregisterFromGlobalInputCallback(n"OnPostOnRelease", this, n"OnGlobalInput");
  }

  protected cb func OnGlobalInput(evt: ref<inkPointerEvent>) {
    if evt.IsAction(n"mouse_left") {
      if !IsDefined(evt.GetTarget()) || !evt.GetTarget().CanSupportFocus() {
        this.m_searchInput.GetGameController().RequestSetFocus(null);
      }
    }
  }

  protected cb func OnSearchInput(widget: wref<inkWidget>) {
    this.m_delaySystem.CancelCallback(this.m_searchEventDelayID);
    this.m_searchEventDelayID = this.m_delaySystem.DelayCallback(this.m_searchEventCallback, 0.25, false);
  }

  public func TriggerSearchEvent() {
    this.QueueEvent(SearchEvent.Create(this.m_searchInput.GetText()));
  }

  public static func Create() -> ref<SearchInput> {
    let self = new SearchInput();
    self.CreateInstance();

    return self;
  }
}

class SearchInputCallback extends DelayCallback {
  protected let m_controller: wref<SearchInput>;

  public func Call() {
    if IsDefined(this.m_controller) {
      this.m_controller.TriggerSearchEvent();
    }
  }

  public static func Create(controller: ref<SearchInput>) -> ref<SearchInputCallback> {
    let self = new SearchInputCallback();
    self.m_controller = controller;

    return self;
  }
}