import Combine
import SwiftUI

import UIServices

// swiftformat:disable indent
public final class ModalTransitionTestFlowController: UIHostingController<ModalTransitionTestView>,
                                                      ModalTransitionTestFlowControllerService,
                                                      FullScreenModalFlowControllerDelegate,
                                                      NoticeAlertFlowControllerDelegate,
                                                      PageSheetModalFlowControllerDelegate {
// swiftformat:enable indent
  private let _fullScreenModalProvider: () -> FullScreenModalFlowControllerService
  private let _noticeAlertProvider: () -> NoticeAlertFlowControllerService
  private let _pageSheetModalProvider: () -> PageSheetModalFlowControllerService

  private var _cancellable = Set<AnyCancellable>()

  private var _viewModel: ModalTransitionTestViewModel {
    rootView.viewModel
  }

  public init(
    rootView: ModalTransitionTestView,
    fullScreenModalProvider: @autoclosure @escaping () -> FullScreenModalFlowControllerService,
    noticeAlertProvider: @autoclosure @escaping () -> NoticeAlertFlowControllerService,
    pageSheetModalProvider: @autoclosure @escaping () -> PageSheetModalFlowControllerService
  ) {
    self._fullScreenModalProvider = fullScreenModalProvider
    self._noticeAlertProvider = noticeAlertProvider
    self._pageSheetModalProvider = pageSheetModalProvider

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
        case .alert:
          self._showNoticeAlertView()

        case .fullScreen:
          self._showFullScreenModalView()

        case .pageSheet:
          self._showPageSheetModalView()
        }
      }
      .store(in: &_cancellable)
  }

  public func noticeAlertFlowControllerShouldDismiss(_ flowController: NoticeAlertFlowControllerService) {
    if presentedViewController == flowController {
      dismiss(animated: true)
    }
  }

  public func fullScreenModalFlowControllerShouldDismiss(_ flowController: FullScreenModalFlowControllerService) {
    if presentedViewController == flowController {
      dismiss(animated: true)
    }
  }

  public func pageSheetModalFlowControllerShouldDismiss(_ flowController: PageSheetModalFlowControllerService) {
    if presentedViewController == flowController {
      dismiss(animated: true)
    }
  }

  private func _showNoticeAlertView() {
    let alert = _noticeAlertProvider()
    alert.delegate = self

    present(alert, animated: true)

    alert.start(title: "Notice", message: "This will be dismissed")
  }

  private func _showFullScreenModalView() {
    let modal = _fullScreenModalProvider()
    modal.delegate = self

    present(modal, animated: true)

    modal.start()
  }

  private func _showPageSheetModalView() {
    let modal = _pageSheetModalProvider()
    modal.delegate = self

    present(modal, animated: true)

    modal.start()
  }
}
