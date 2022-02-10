import Resolver

import FeedView
import UIServices

extension Resolver {
  static func registerFeedView() {
    register { FeedViewModel() }
    register {
      FeedFlowController(
        viewModel: resolve(),
        appSalesProvider: resolve(),
        feedListProvider: resolve()
      ) as FeedFlowControllerService
    }
  }
}
