import Entities

public protocol SettingsMenuFlowControllerDelegate: AnyObject {
  func settingsMenuFlowController(
    _ flowController: SettingsMenuFlowControllerService,
    didSelect menuRow: SettingsMenu.Row
  )
}
