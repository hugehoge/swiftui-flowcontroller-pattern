import Combine
import SwiftUI

import Entities
import UIServices

public final class AppSalesFlowController: UIHostingController<AppSalesView>, AppSalesFlowControllerService {
  private var _cancellable = Set<AnyCancellable>()

  private var _viewModel: AppSalesViewModel {
    rootView.viewModel
  }

  override public init(rootView: AppSalesView) {
    super.init(rootView: rootView)

    // FIXME: Using only `View.navigationBarTitleDisplayMode(.inline)` does not be a smooth transition
    navigationItem.largeTitleDisplayMode = .never
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public func start(segment: AppSegment) {
    _cancellable = Set()

    _viewModel.segment = segment

    _viewModel.navigationSignal
      .receive(on: DispatchQueue.main)
      .sink { [weak self] navigation in
        guard let self = self else { return }

        switch navigation {
        case let .appStore(url):
          self.openExternally(link: url)
        }
      }
      .store(in: &_cancellable)

    _viewModel.fetch()
  }
}
