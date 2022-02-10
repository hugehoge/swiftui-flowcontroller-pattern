import Foundation
import UIKit

import Entities
import UIServices

// swiftformat:disable indent
public final class SettingsFlowController: UIViewController,
                                           UINavigationControllerDelegate,
                                           SettingsFlowControllerService,
                                           SettingsMenuFlowControllerDelegate,
                                           PushTransitionTestFlowControllerDelegate {
// swiftformat:enable indent
  private let _viewModel: SettingsViewModel
  private let _settingsMenuProvider: () -> SettingsMenuFlowControllerService
  private let _userNameSettingProvider: () -> UserNameSettingFlowControllerService
  private let _feedLanguageSettingProvider: () -> FeedLanguageSettingFlowControllerService
  private let _keyboardTestProvider: () -> KeyboardTestFlowControllerService
  private let _toolbarTestProvider: () -> ToolbarTestFlowControllerService
  private let _pushTransitionTestProvider: () -> PushTransitionTestFlowControllerService
  private let _modalTransitionTestProvider: () -> ModalTransitionTestFlowControllerService
  private let _licensesProvider: () -> LicensesFlowControllerService

  private let _embeddedNavigationController = UINavigationController()

  public init(
    viewModel: SettingsViewModel,
    settingsMenuProvider: @autoclosure @escaping () -> SettingsMenuFlowControllerService,
    userNameSettingProvider: @autoclosure @escaping () -> UserNameSettingFlowControllerService,
    feedLanguageSettingProvider: @autoclosure @escaping () -> FeedLanguageSettingFlowControllerService,
    keyboardTestProvider: @autoclosure @escaping () -> KeyboardTestFlowControllerService,
    toolbarTestProvider: @autoclosure @escaping () -> ToolbarTestFlowControllerService,
    pushTransitionTestProvider: @autoclosure @escaping () -> PushTransitionTestFlowControllerService,
    modalTransitionTestProvider: @autoclosure @escaping () -> ModalTransitionTestFlowControllerService,
    licensesProvider: @autoclosure @escaping () -> LicensesFlowControllerService
  ) {
    self._viewModel = viewModel
    self._settingsMenuProvider = settingsMenuProvider
    self._userNameSettingProvider = userNameSettingProvider
    self._feedLanguageSettingProvider = feedLanguageSettingProvider
    self._keyboardTestProvider = keyboardTestProvider
    self._toolbarTestProvider = toolbarTestProvider
    self._pushTransitionTestProvider = pushTransitionTestProvider
    self._modalTransitionTestProvider = modalTransitionTestProvider
    self._licensesProvider = licensesProvider

    super.init(nibName: nil, bundle: nil)

    _embeddedNavigationController.delegate = self
    _embeddedNavigationController.navigationBar.prefersLargeTitles = true

    addContent(_embeddedNavigationController)
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public func start() {
    let menu = _settingsMenuProvider()
    menu.delegate = self

    _embeddedNavigationController.setViewControllers([menu], animated: false)

    menu.start()
  }

  // MARK: UINavigationControllerDelegate

  public func navigationController(
    _: UINavigationController,
    willShow viewController: UIViewController,
    animated _: Bool
  ) {
    // Need to manage toolbar visibility
    switch viewController {
    case is ToolbarTestFlowControllerService,
         is PushTransitionTestFlowControllerService:
      _embeddedNavigationController.setToolbarHidden(false, animated: false)

    default:
      _embeddedNavigationController.setToolbarHidden(true, animated: false)
    }
  }

  // MARK: SettingsMenuFlowControllerDelegate

  public func settingsMenuFlowController(_: SettingsMenuFlowControllerService, didSelect menuRow: SettingsMenu.Row) {
    switch menuRow {
    case .userNameSetting:
      _showUserNameSettingView()

    case .feedLanguageSetting:
      _showFeedLanguageSettingView()

    case .keyboardTest:
      _showKeyboardTestView()

    case .toolbarTest:
      _showToolbarTestView()

    case .pushTransitionTest:
      _showPushTransitionTestView()

    case .modalTransitionTest:
      _showModalTransitionTestView()

    case .licenses:
      _showLicensesView()

    default:
      break
    }
  }

  // MARK: PushTransitionTestFlowControllerDelegate

  public func pushTransitionTestFlowController(
    _: PushTransitionTestFlowControllerService,
    nextWith forwardText: String
  ) {
    _showPushTransitionTestView(forwardedText: forwardText)
  }

  public func pushTransitionTestFlowControllerPopToRoot(_: PushTransitionTestFlowControllerService) {
    _embeddedNavigationController.popToRootViewController(animated: true)
  }

  // MARK: Private methods

  private func _showUserNameSettingView() {
    let userName = _userNameSettingProvider()

    _embeddedNavigationController.pushViewController(userName, animated: true)

    userName.start()
  }

  private func _showFeedLanguageSettingView() {
    let feedLanguage = _feedLanguageSettingProvider()

    _embeddedNavigationController.pushViewController(feedLanguage, animated: true)

    feedLanguage.start()
  }

  private func _showKeyboardTestView() {
    let keyboardTest = _keyboardTestProvider()

    _embeddedNavigationController.pushViewController(keyboardTest, animated: true)

    keyboardTest.start()
  }

  private func _showToolbarTestView() {
    let toolbarTest = _toolbarTestProvider()

    _embeddedNavigationController.pushViewController(toolbarTest, animated: true)

    toolbarTest.start()
  }

  private func _showPushTransitionTestView(forwardedText: String = "") {
    let pushTest = _pushTransitionTestProvider()
    pushTest.delegate = self

    _embeddedNavigationController.pushViewController(pushTest, animated: true)

    pushTest.start(forwardedText: forwardedText)
  }

  private func _showModalTransitionTestView() {
    let modalTest = _modalTransitionTestProvider()

    _embeddedNavigationController.pushViewController(modalTest, animated: true)

    modalTest.start()
  }

  private func _showLicensesView() {
    let licenses = _licensesProvider()

    _embeddedNavigationController.pushViewController(licenses, animated: true)

    licenses.start()
  }
}
