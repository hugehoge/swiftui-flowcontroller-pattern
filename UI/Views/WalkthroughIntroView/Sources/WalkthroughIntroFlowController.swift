import SwiftUI

import UIServices

// swiftformat:disable indent
public final class WalkthroughIntroFlowController: UIHostingController<WalkthroughIntroView>,
                                                   WalkthroughIntroFlowControllerService {
// swiftformat:enable indent
  private var _viewModel: WalkthroughIntroViewModel {
    rootView.viewModel
  }

  override public init(rootView: WalkthroughIntroView) {
    super.init(rootView: rootView)
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public func start() { }
}
