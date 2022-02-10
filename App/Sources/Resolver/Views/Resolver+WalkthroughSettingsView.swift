import Resolver

import UIServices
import WalkthroughSettingsView

extension Resolver {
  static func registerWalkthroughSettingsView() {
    register { WalkthroughSettingsViewModel() }
    register { WalkthroughSettingsView(viewModel: resolve()) }
    register { WalkthroughSettingsFlowController(rootView: resolve()) as WalkthroughSettingsFlowControllerService }
  }
}
