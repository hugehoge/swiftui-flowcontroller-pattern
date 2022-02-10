import Resolver

import SettingsMenuView
import UIServices

extension Resolver {
  static func registerSettingsMenuView() {
    register { SettingsMenuViewModel(preferenceRepository: resolve()) }
    register { SettingsMenuView(viewModel: resolve()) }
    register { SettingsMenuFlowController(rootView: resolve()) as SettingsMenuFlowControllerService }
  }
}
