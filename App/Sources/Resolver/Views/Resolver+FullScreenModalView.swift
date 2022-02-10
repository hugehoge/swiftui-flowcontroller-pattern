import Resolver

import FullScreenModalView
import UIServices

extension Resolver {
  static func registerFullScreenModalView() {
    register { FullScreenModalViewModel() }
    register { FullScreenModalView(viewModel: resolve()) }
    register { FullScreenModalFlowController(rootView: resolve()) as FullScreenModalFlowControllerService }
  }
}
