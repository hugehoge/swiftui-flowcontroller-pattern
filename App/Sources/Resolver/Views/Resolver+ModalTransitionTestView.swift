import Resolver

import ModalTransitionTestView
import UIServices

extension Resolver {
  static func registerModalTransitionTestView() {
    register { ModalTransitionTestViewModel() }
    register { ModalTransitionTestView(viewModel: resolve()) }
    register {
      ModalTransitionTestFlowController(
        rootView: resolve(),
        fullScreenModalProvider: resolve(),
        noticeAlertProvider: resolve(),
        pageSheetModalProvider: resolve()
      ) as ModalTransitionTestFlowControllerService
    }
  }
}
