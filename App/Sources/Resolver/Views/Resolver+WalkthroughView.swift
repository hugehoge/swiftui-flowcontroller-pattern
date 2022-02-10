import Resolver

import UIServices
import WalkthroughView

extension Resolver {
  static func registerWalkthroughView() {
    register { WalkthroughViewModel(appStateRepository: resolve(), preferencesRepository: resolve()) }
    register {
      WalkthroughFlowController(
        viewModel: resolve(),
        walkthroughIntroProvider: resolve(),
        walkthroughSettingsProvider: resolve(),
        walkthroughFinishProvider: resolve()
      ) as WalkthroughFlowControllerService
    }
  }
}
