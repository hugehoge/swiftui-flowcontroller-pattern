import Resolver

import MainView
import UIServices

extension Resolver {
  static func registerMainView() {
    register { MainViewModel() }
    register {
      MainFlowController(
        viewModel: resolve(),
        feedProvider: resolve(),
        settingsProvider: resolve()
      ) as MainFlowControllerService
    }
  }
}
