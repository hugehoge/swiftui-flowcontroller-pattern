import UIKit

public protocol FeedListFlowControllerService: UIViewController {
  var delegate: FeedListFlowControllerDelegate? { get set }

  func start()
}
