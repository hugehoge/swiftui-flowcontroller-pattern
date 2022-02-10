import UIKit

import Entities
import Resources
import UIServices

// swiftformat:disable indent
public final class WalkthroughFlowController: UIViewController,
                                              UIPageViewControllerDataSource,
                                              WalkthroughFlowControllerService,
                                              WalkthroughSettingsFlowControllerDelegate,
                                              WalkthroughFinishFlowControllerDelegate {
// swiftformat:enable indent
  private let _viewModel: WalkthroughViewModel
  private let _walkthroughIntroProvider: () -> WalkthroughIntroFlowControllerService
  private let _walkthroughSettingsProvider: () -> WalkthroughSettingsFlowControllerService
  private let _walkthroughFinishProvider: () -> WalkthroughFinishFlowControllerService

  private let _embeddedPageViewController = UIPageViewController(
    transitionStyle: .scroll,
    navigationOrientation: .horizontal,
    options: [:]
  )

  private var _pages: [UIViewController] = []

  public init(
    viewModel: WalkthroughViewModel,
    walkthroughIntroProvider: @autoclosure @escaping () -> WalkthroughIntroFlowControllerService,
    walkthroughSettingsProvider: @autoclosure @escaping () -> WalkthroughSettingsFlowControllerService,
    walkthroughFinishProvider: @autoclosure @escaping () -> WalkthroughFinishFlowControllerService
  ) {
    self._viewModel = viewModel
    self._walkthroughIntroProvider = walkthroughIntroProvider
    self._walkthroughSettingsProvider = walkthroughSettingsProvider
    self._walkthroughFinishProvider = walkthroughFinishProvider

    super.init(nibName: nil, bundle: nil)

    _embeddedPageViewController.view.backgroundColor = Asset.background.color
    _embeddedPageViewController.dataSource = self

    addContent(_embeddedPageViewController)
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override public func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    // FIXME: Workaround for the page control color changes
    UIPageControl.appearance().pageIndicatorTintColor = .secondaryLabel
    UIPageControl.appearance().currentPageIndicatorTintColor = .tintColor
  }

  override public func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    // FIXME: Workaround for the broken layout of WalkthroughIntroViewController
    //        It would be caused in the initial view when UINavigationController in UIPageViewController
    _embeddedPageViewController.setViewControllers([_pages[1]], direction: .forward, animated: false)
    _embeddedPageViewController.setViewControllers([_pages[0]], direction: .forward, animated: false)
  }

  override public func viewWillDisappear(_ animated: Bool) {
    UIPageControl.appearance().pageIndicatorTintColor = nil
    UIPageControl.appearance().currentPageIndicatorTintColor = nil

    super.viewWillDisappear(animated)
  }

  public func start() {
    let intro = _walkthroughIntroProvider()
    let settings = _walkthroughSettingsProvider()
    let finish = _walkthroughFinishProvider()

    settings.delegate = self
    finish.delegate = self

    _pages = [intro, settings, finish]

    _embeddedPageViewController.setViewControllers([intro], direction: .forward, animated: false)

    intro.start()
    settings.start()
    finish.start()
  }

  // MARK: UIPageViewControllerDelegate

  public func pageViewController(
    _: UIPageViewController,
    viewControllerBefore viewController: UIViewController
  ) -> UIViewController? {
    if let index = _pages.firstIndex(where: { $0 == viewController }), _pages.indices.contains(index - 1) {
      return _pages[index - 1]
    } else {
      return nil
    }
  }

  public func pageViewController(
    _: UIPageViewController,
    viewControllerAfter viewController: UIViewController
  ) -> UIViewController? {
    if let index = _pages.firstIndex(where: { $0 == viewController }), _pages.indices.contains(index + 1) {
      return _pages[index + 1]
    } else {
      return nil
    }
  }

  public func presentationCount(for _: UIPageViewController) -> Int {
    _pages.count
  }

  public func presentationIndex(for _: UIPageViewController) -> Int {
    0
  }

  // MARK: WalkthroughSettingsFlowControllerDelegate

  public func walkthroughSettingsFlowController(
    _: WalkthroughSettingsFlowControllerService,
    update feedLanguage: FeedLanguage
  ) {
    _viewModel.feedLanguage = feedLanguage
  }

  public func walkthroughSettingsFlowController(_: WalkthroughSettingsFlowControllerService, update userName: String) {
    _viewModel.userName = userName
  }

  // MARK: WalkthroughFinishFlowControllerDelegate

  public func walkthroughFinishFlowControllerFinishWalkthrough(_: WalkthroughFinishFlowControllerService) {
    _viewModel.finishWalkthrough()
  }
}
