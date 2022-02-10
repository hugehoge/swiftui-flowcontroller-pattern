import Combine
import SwiftUI

import UIServices

// swiftformat:disable indent
public final class SettingsMenuFlowController: UIHostingController<SettingsMenuView>,
                                               SettingsMenuFlowControllerService {
// swiftformat:enable indent
  public weak var delegate: SettingsMenuFlowControllerDelegate?

  private var _cancellable = Set<AnyCancellable>()

  private var _viewModel: SettingsMenuViewModel {
    rootView.viewModel
  }

  override public init(rootView: SettingsMenuView) {
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
        case let .menu(row):
          self.delegate?.settingsMenuFlowController(self, didSelect: row)
        }
      }
      .store(in: &_cancellable)
  }
}
