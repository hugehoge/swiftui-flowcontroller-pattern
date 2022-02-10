import Combine
import Foundation
import SwiftUI
import UIKit

import UIServices

public final class RootFlowController: UIViewController, RootFlowControllerService {
  private let _rootViewModel: RootViewModel
  private let _walkthroughProvider: () -> WalkthroughFlowControllerService
  private let _mainProvider: () -> MainFlowControllerService

  private var _cancellable = Set<AnyCancellable>()

  public init(
    rootViewModel: RootViewModel,
    walkthroughProvider: @autoclosure @escaping () -> WalkthroughFlowControllerService,
    mainProvider: @autoclosure @escaping () -> MainFlowControllerService
  ) {
    self._rootViewModel = rootViewModel
    self._walkthroughProvider = walkthroughProvider
    self._mainProvider = mainProvider

    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public func start() {
    _cancellable = Set()

    _rootViewModel.navigationStream
      .receive(on: DispatchQueue.main)
      .sink { [weak self] navigation in
        guard let self = self else { return }

        switch navigation {
        case .main:
          self.startMain()

        case .walkthrough:
          self.startWalkthrough()
        }
      }
      .store(in: &_cancellable)
  }

  private func startWalkthrough() {
    dismiss(animated: false) { [weak self] in
      guard let self = self else { return }

      let walkthrough = self._walkthroughProvider()

      self.removeAllContentViewController()
      self.addContent(walkthrough)

      walkthrough.start()
    }
  }

  private func startMain() {
    dismiss(animated: false) { [weak self] in
      guard let self = self else { return }

      let main = self._mainProvider()

      self.removeAllContentViewController()
      self.addContent(main)

      main.start()
    }
  }
}
