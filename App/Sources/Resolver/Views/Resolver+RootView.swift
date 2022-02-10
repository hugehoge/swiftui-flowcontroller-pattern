import Resolver

import RootView
import UIServices

extension Resolver {
  static func registerRootView() {
    register { RootViewModel(appStateRepository: resolve()) }
    register {
      RootFlowController(
        rootViewModel: resolve(),
        walkthroughProvider: resolve(),
        mainProvider: resolve()
      ) as RootFlowControllerService
    }
  }
}
