import Resolver

import FeedListView
import UIServices

extension Resolver {
  static func registerFeedListView() {
    register { FeedListViewModel(feedRepository: resolve(), preferencesRepository: resolve()) }
    register { FeedListView(viewModel: resolve()) }
    register { FeedListFlowController(rootView: resolve()) as FeedListFlowControllerService }
  }
}
