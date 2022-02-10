import Resolver

import SettingsView
import UIServices

extension Resolver {
  static func registerSettingsView() {
    register { SettingsViewModel() }
    register {
      SettingsFlowController(
        viewModel: resolve(),
        settingsMenuProvider: resolve(),
        userNameSettingProvider: resolve(),
        feedLanguageSettingProvider: resolve(),
        keyboardTestProvider: resolve(),
        toolbarTestProvider: resolve(),
        pushTransitionTestProvider: resolve(),
        modalTransitionTestProvider: resolve(),
        licensesProvider: resolve()
      ) as SettingsFlowControllerService
    }
  }
}
