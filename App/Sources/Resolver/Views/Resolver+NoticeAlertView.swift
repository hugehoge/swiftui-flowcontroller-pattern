import Resolver

import NoticeAlertView
import UIServices

extension Resolver {
  static func registerNoticeAlertView() {
    register { NoticeAlertFlowController.instantiate() as NoticeAlertFlowControllerService }
  }
}
