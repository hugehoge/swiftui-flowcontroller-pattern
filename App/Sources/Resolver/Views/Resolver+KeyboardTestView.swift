import Resolver

import KeyboardTestView
import UIServices

extension Resolver {
  static func registerKeyboardTestView() {
    register { KeyboardTestViewModel() }
    register { KeyboardTestView(viewModel: resolve()) }
    register { KeyboardTestFlowController(rootView: resolve()) as KeyboardTestFlowControllerService }
  }
}
