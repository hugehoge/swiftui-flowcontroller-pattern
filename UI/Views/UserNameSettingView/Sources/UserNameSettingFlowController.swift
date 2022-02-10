import SwiftUI

import UIServices

// swiftformat:disable indent
public final class UserNameSettingFlowController: UIHostingController<UserNameSettingView>,
                                                  UserNameSettingFlowControllerService {
// swiftformat:enable indent
  private var _viewModel: UserNameSettingViewModel {
    rootView.viewModel
  }

  override public init(rootView: UserNameSettingView) {
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
