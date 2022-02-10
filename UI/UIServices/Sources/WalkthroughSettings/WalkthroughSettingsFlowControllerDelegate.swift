import Entities

public protocol WalkthroughSettingsFlowControllerDelegate: AnyObject {
  func walkthroughSettingsFlowController(
    _ flowController: WalkthroughSettingsFlowControllerService,
    update feedLanguage: FeedLanguage
  )
  func walkthroughSettingsFlowController(
    _ flowController: WalkthroughSettingsFlowControllerService,
    update userName: String
  )
}
