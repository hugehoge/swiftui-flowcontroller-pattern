import Combine
import SwiftUI

import UIServices

// swiftformat:disable indent
public final class PageSheetModalFlowController: UIHostingController<PageSheetModalView>,
                                                 PageSheetModalFlowControllerService {
// swiftformat:enable indent
  public weak var delegate: PageSheetModalFlowControllerDelegate?

  private var _cancellable = Set<AnyCancellable>()

  private var _viewModel: PageSheetModalViewModel {
    rootView.viewModel
  }

  override public init(rootView: PageSheetModalView) {
    super.init(rootView: rootView)

    modalPresentationStyle = .pageSheet
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
        case .dismiss:
          self.delegate?.pageSheetModalFlowControllerShouldDismiss(self)
        }
      }
      .store(in: &_cancellable)
  }
}
