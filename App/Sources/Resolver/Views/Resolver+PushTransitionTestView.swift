import Resolver

import PushTransitionTestView
import UIServices

extension Resolver {
  static func registerPushTransitionTestView() {
    register { PushTransitionTestViewModel() }
    register { PushTransitionTestView(viewModel: resolve()) }
    register { PushTransitionTestFlowController(rootView: resolve()) as PushTransitionTestFlowControllerService }
  }
}
