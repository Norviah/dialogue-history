module DialogueHistory.Annotations

import DialogueHistory.Structs.ConversationFilterCategory


@addMethod(DropdownListController)
public final func Setup(owner: wref<inkGameController>, const data: script_ref<[ref<DropdownItemData>]>, triggerButton: ref<DropdownButtonController>, defaultItem: ConversationFilterCategory) -> Void {
  this.m_ownerController = owner;
  this.m_triggerButton = triggerButton;

  if Equals(defaultItem, ConversationFilterCategory.All) {
    this.SetupData(data);
  } else {
    this.SetupData(data, defaultItem);
  }
}

@addMethod(DropdownListController)
protected func FindController(identifier: ConversationFilterCategory) -> ref<DropdownElementController> {
  let container: wref<inkCompoundWidget> = this.m_listContainer.widget as inkCompoundWidget;

  if !IsDefined(container) {
    return null;
  }

  for child in container.children.children {
    let controller: ref<DropdownElementController> = child.GetController() as DropdownElementController;
    let filter: ConversationFilterCategory = FromVariant<ConversationFilterCategory>(controller.GetIdentifier());

    if IsDefined(controller) && Equals(filter, identifier) {
      return controller;
    }
  }

  return null;
}

@addMethod(DropdownListController)
private final func SetupData(const data: script_ref<[ref<DropdownItemData>]>, defaultItem: ConversationFilterCategory) -> Void {
  this.SetupData(data);

  let itemController: ref<DropdownElementController> = this.FindController(defaultItem);

  if IsDefined(itemController) {
    this.m_activeElement.SetActive(false);
    this.m_activeElement = itemController;
    this.m_activeElement.SetActive(true);
  }
}