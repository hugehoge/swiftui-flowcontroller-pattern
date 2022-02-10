import SwiftUI

import UIServices

// swiftformat:disable indent
public final class KeyboardTestFlowController: UIHostingController<KeyboardTestView>,
                                               KeyboardTestFlowControllerService {
// swiftformat:enable indent
  private var _viewModel: KeyboardTestViewModel {
    rootView.viewModel
  }

  override public init(rootView: KeyboardTestView) {
    super.init(rootView: rootView)
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public func start() { }
}
