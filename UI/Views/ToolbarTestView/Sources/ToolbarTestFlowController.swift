import SwiftUI

import UIServices

public final class ToolbarTestFlowController: UIHostingController<ToolbarTestView>, ToolbarTestFlowControllerService {
  private var _viewModel: ToolbarTestViewModel {
    rootView.viewModel
  }

  override public init(rootView: ToolbarTestView) {
    super.init(rootView: rootView)
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public func start() { }
}
