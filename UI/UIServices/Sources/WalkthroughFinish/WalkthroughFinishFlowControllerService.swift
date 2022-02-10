import UIKit

public protocol WalkthroughFinishFlowControllerService: UIViewController {
  var delegate: WalkthroughFinishFlowControllerDelegate? { get set }

  func start()
}
