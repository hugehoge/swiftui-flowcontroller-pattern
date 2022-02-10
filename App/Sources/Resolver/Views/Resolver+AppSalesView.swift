import Resolver

import AppSalesView
import UIServices

extension Resolver {
  static func registerAppSalesView() {
    register { AppSalesViewModel(feedRepository: resolve(), preferencesRepository: resolve()) }
    register { AppSalesView(viewModel: resolve()) }
    register { AppSalesFlowController(rootView: resolve()) as AppSalesFlowControllerService }
  }
}
