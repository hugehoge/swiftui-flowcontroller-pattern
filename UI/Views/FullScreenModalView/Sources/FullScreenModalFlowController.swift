import Combine
import SwiftUI

import UIServices

// swiftformat:disable indent
public final class FullScreenModalFlowController: UIHostingController<FullScreenModalView>,
                                                  FullScreenModalFlowControllerService {
// swiftformat:enable indent
  public weak var delegate: FullScreenModalFlowControllerDelegate?

  private var _cancellable = Set<AnyCancellable>()

  private var _viewModel: FullScreenModalViewModel {
    rootView.viewModel
  }

  override public init(rootView: FullScreenModalView) {
    super.init(rootView: rootView)

    modalPresentationStyle = .fullScreen
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
          self.delegate?.fullScreenModalFlowControllerShouldDismiss(self)
        }
      }
      .store(in: &_cancellable)
  }
}
