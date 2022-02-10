import Resolver

import PageSheetModalView
import UIServices

extension Resolver {
  static func registerPageSheetModalView() {
    register { PageSheetModalViewModel() }
    register { PageSheetModalView(viewModel: resolve()) }
    register { PageSheetModalFlowController(rootView: resolve()) as PageSheetModalFlowControllerService }
  }
}
