import UIKit

public protocol NoticeAlertFlowControllerService: UIViewController {
  var delegate: NoticeAlertFlowControllerDelegate? { get set }

  func start(title: String?, message: String?)
}
