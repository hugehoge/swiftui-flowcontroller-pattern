import Combine
import SwiftUI

import UIServices

// swiftformat:disable indent
public final class PushTransitionTestFlowController: UIHostingController<PushTransitionTestView>,
                                                     PushTransitionTestFlowControllerService {
// swiftformat:enable indent
  public weak var delegate: PushTransitionTestFlowControllerDelegate?

  private var _cancellable = Set<AnyCancellable>()

  private var _viewModel: PushTransitionTestViewModel {
    rootView.viewModel
  }

  override public init(rootView: PushTransitionTestView) {
    super.init(rootView: rootView)
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public func start(forwardedText: String) {
    _cancellable = Set()

    _viewModel.forwardText = forwardedText

    _viewModel.navigationSignal
      .receive(on: DispatchQueue.main)
      .sink { [weak self] navigation in
        guard let self = self else { return }

        switch navigation {
        case .next:
          self.delegate?.pushTransitionTestFlowController(self, nextWith: self._viewModel.forwardText)

        case .popToRoot:
          self.delegate?.pushTransitionTestFlowControllerPopToRoot(self)
        }
      }
      .store(in: &_cancellable)
  }
}
