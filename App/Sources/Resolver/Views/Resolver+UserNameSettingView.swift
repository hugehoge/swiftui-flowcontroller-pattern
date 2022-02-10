import Resolver

import UIServices
import UserNameSettingView

extension Resolver {
  static func registerUserNameSettingView() {
    register { UserNameSettingViewModel(preferencesRepository: resolve()) }
    register { UserNameSettingView(viewModel: resolve()) }
    register { UserNameSettingFlowController(rootView: resolve()) as UserNameSettingFlowControllerService }
  }
}
