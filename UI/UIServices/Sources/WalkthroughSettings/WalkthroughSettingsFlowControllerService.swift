import UIKit

public protocol WalkthroughSettingsFlowControllerService: UIViewController {
  var delegate: WalkthroughSettingsFlowControllerDelegate? { get set }

  func start()
}
