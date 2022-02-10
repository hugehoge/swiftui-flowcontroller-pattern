import UIKit

public protocol PushTransitionTestFlowControllerService: UIViewController {
  var delegate: PushTransitionTestFlowControllerDelegate? { get set }

  func start(forwardedText: String)
}
