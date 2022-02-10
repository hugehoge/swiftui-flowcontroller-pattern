import Resolver

import UIServices
import WalkthroughFinishView

extension Resolver {
  static func registerWalkthroughFinishView() {
    register { WalkthroughFinishViewModel() }
    register { WalkthroughFinishView(viewModel: resolve()) }
    register { WalkthroughFinishFlowController(rootView: resolve()) as WalkthroughFinishFlowControllerService }
  }
}
