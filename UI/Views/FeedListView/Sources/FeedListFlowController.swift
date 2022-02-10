import Combine
import SwiftUI

import Entities
import UIServices

public final class FeedListFlowController: UIHostingController<FeedListView>, FeedListFlowControllerService {
  public weak var delegate: FeedListFlowControllerDelegate?

  private var _cancellable = Set<AnyCancellable>()

  private var _viewModel: FeedListViewModel {
    rootView.viewModel
  }

  override public init(rootView: FeedListView) {
    super.init(rootView: rootView)
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public func start() {
    _cancellable = Set()

    _viewModel.navigationSignal
      .receive(on: DispatchQueue.main)
      .sink { [weak self] navigation in
        guard let self = self else { return }

        switch navigation {
        case let .news(url):
          // self._showBrowseView(url: url)
          self.openInternally(link: url)

        case let .appStore(url):
          self.openExternally(link: url)

        case .freeAppRanking:
          self.delegate?.feedListFlowController(self, didSelect: .freeApp)

        case .paidAppRanking:
          self.delegate?.feedListFlowController(self, didSelect: .paidApp)
        }
      }
      .store(in: &_cancellable)

    _viewModel.fetch()
  }
}
