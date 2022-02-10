import UIKit

import UIServices

public final class NoticeAlertFlowController: UIAlertController, NoticeAlertFlowControllerService {
  // This is an experimental implementation for using UIAlertController based on the FlowController pattern.
  // UIAlertController subclassing is known as a bad practice.
  // See also https://developer.apple.com/documentation/uikit/uialertcontroller

  public static func instantiate() -> NoticeAlertFlowController {
    let alert = NoticeAlertFlowController(title: nil, message: nil, preferredStyle: .alert)

    alert.addAction(
      UIAlertAction(title: "OK", style: .default) { _ in
        alert.delegate?.noticeAlertFlowControllerShouldDismiss(alert)
      }
    )

    return alert
  }

  public weak var delegate: NoticeAlertFlowControllerDelegate?

  public func start(title: String?, message: String?) {
    self.title = title
    self.message = message
  }
}
