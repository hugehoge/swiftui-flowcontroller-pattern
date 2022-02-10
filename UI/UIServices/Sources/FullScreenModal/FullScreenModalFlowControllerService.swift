import UIKit

public protocol FullScreenModalFlowControllerService: UIViewController {
  var delegate: FullScreenModalFlowControllerDelegate? { get set }

  func start()
}
