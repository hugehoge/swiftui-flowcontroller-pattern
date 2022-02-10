import Resolver

import FeedLanguageSettingView
import UIServices

extension Resolver {
  static func registerFeedLanguageSettingView() {
    register { FeedLanguageSettingViewModel(preferencesRepository: resolve()) }
    register { FeedLanguageSettingView(viewModel: resolve()) }
    register { FeedLanguageSettingFlowController(rootView: resolve()) as FeedLanguageSettingFlowControllerService }
  }
}
