import UIKit

import RepositoryServices
import UIServices

public final class MainFlowController: UIViewController, MainFlowControllerService {
  private let _viewModel: MainViewModel
  private let _feedProvider: () -> FeedFlowControllerService
  private let _settingsProvider: () -> SettingsFlowControllerService

  private let _embeddedTabBarController = UITabBarController()

  public init(
    viewModel: MainViewModel,
    feedProvider: @autoclosure @escaping () -> FeedFlowControllerService,
    settingsProvider: @autoclosure @escaping () -> SettingsFlowControllerService
  ) {
    self._viewModel = viewModel
    self._feedProvider = feedProvider
    self._settingsProvider = settingsProvider

    super.init(nibName: nil, bundle: nil)

    addContent(_embeddedTabBarController)
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public func start() {
    let feed = _feedProvider()
    let settings = _settingsProvider()

    feed.tabBarItem = UITabBarItem(
      title: "Feed",
      image: UIImage(systemName: "doc.text.image"), // SFSymbol has no Feed icon
      tag: 0
    )
    settings.tabBarItem = UITabBarItem(
      title: "Settings",
      image: UIImage(systemName: "wrench.and.screwdriver"),
      tag: 1
    )

    _embeddedTabBarController.setViewControllers([feed, settings], animated: false)
    _embeddedTabBarController.selectedIndex = 0

    feed.start()
    settings.start()
  }
}
