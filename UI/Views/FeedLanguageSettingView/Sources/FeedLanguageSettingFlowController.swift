import SwiftUI

import UIServices

// swiftformat:disable indent
public final class FeedLanguageSettingFlowController: UIHostingController<FeedLanguageSettingView>,
                                                      FeedLanguageSettingFlowControllerService {
// swiftformat:enable indent
  private var _viewModel: FeedLanguageSettingViewModel {
    rootView.viewModel
  }

  override public init(rootView: FeedLanguageSettingView) {
    super.init(rootView: rootView)

    // FIXME: Using only `View.navigationBarTitleDisplayMode(.inline)` does not be a smooth transition
    navigationItem.largeTitleDisplayMode = .never
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public func start() { }
}
