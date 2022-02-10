import Resolver

import UIServices
import WalkthroughIntroView

extension Resolver {
  static func registerWalkthroughIntroView() {
    register { WalkthroughIntroViewModel() }
    register { WalkthroughIntroView(viewModel: resolve()) }
    register { WalkthroughIntroFlowController(rootView: resolve()) as WalkthroughIntroFlowControllerService }
  }
}
