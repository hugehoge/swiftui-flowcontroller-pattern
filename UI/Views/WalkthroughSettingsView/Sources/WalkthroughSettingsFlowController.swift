import Combine
import SwiftUI

import UIServices

// swiftformat:disable indent
public final class WalkthroughSettingsFlowController: UIHostingController<WalkthroughSettingsView>,
                                                      WalkthroughSettingsFlowControllerService {
// swiftformat:enable indent
  public weak var delegate: WalkthroughSettingsFlowControllerDelegate?

  private var _cancellable = Set<AnyCancellable>()

  private var _viewModel: WalkthroughSettingsViewModel {
    rootView.viewModel
  }

  override public init(rootView: WalkthroughSettingsView) {
    super.init(rootView: rootView)
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public func start() {
    _cancellable = Set()

    _viewModel.feedLanguageStream
      .receive(on: DispatchQueue.main)
      .sink { [weak self] language in
        guard let self = self else { return }
        self.delegate?.walkthroughSettingsFlowController(self, update: language)
      }
      .store(in: &_cancellable)

    _viewModel.userNameStream
      .receive(on: DispatchQueue.main)
      .sink { [weak self] name in
        guard let self = self else { return }
        self.delegate?.walkthroughSettingsFlowController(self, update: name)
      }
      .store(in: &_cancellable)
  }
}
