import Combine
import SwiftUI

import UIServices

// swiftformat:disable indent
public final class WalkthroughFinishFlowController: UIHostingController<WalkthroughFinishView>,
                                                    WalkthroughFinishFlowControllerService {
// swiftformat:enable indent
  public weak var delegate: WalkthroughFinishFlowControllerDelegate?

  private var _cancellable = Set<AnyCancellable>()

  private var _viewModel: WalkthroughFinishViewModel {
    rootView.viewModel
  }

  override public init(rootView: WalkthroughFinishView) {
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
        case .finish:
          self.delegate?.walkthroughFinishFlowControllerFinishWalkthrough(self)
        }
      }
      .store(in: &_cancellable)
  }
}
