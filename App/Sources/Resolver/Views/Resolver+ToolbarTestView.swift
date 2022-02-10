import Resolver

import ToolbarTestView
import UIServices

extension Resolver {
  static func registerToolbarTestView() {
    register { ToolbarTestViewModel() }
    register { ToolbarTestView(viewModel: resolve()) }
    register { ToolbarTestFlowController(rootView: resolve()) as ToolbarTestFlowControllerService }
  }
}
