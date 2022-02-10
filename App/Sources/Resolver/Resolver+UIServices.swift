import Resolver

import AppSalesView
import FeedLanguageSettingView
import FeedListView
import UIServices

extension Resolver {
  static func registerUIServices() {
    registerAppSalesView()
    registerFeedLanguageSettingView()
    registerFeedListView()
    registerFeedView()
    registerFullScreenModalView()
    registerKeyboardTestView()
    registerLicensesView()
    registerMainView()
    registerModalTransitionTestView()
    registerNoticeAlertView()
    registerPageSheetModalView()
    registerPushTransitionTestView()
    registerRootView()
    registerSettingsMenuView()
    registerSettingsView()
    registerToolbarTestView()
    registerUserNameSettingView()
    registerWalkthroughFinishView()
    registerWalkthroughIntroView()
    registerWalkthroughSettingsView()
    registerWalkthroughView()
  }
}
