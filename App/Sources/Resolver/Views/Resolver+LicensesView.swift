import Resolver

import LicensesView
import UIServices

extension Resolver {
  static func registerLicensesView() {
    register { LicensesViewModel() }
    register { LicensesView(viewModel: resolve()) }
    register { LicensesFlowController(rootView: resolve()) as LicensesFlowControllerService }
  }
}
