import UIKit

import Entities
import UIServices

public final class FeedFlowController: UIViewController, FeedFlowControllerService, FeedListFlowControllerDelegate {
  private let _viewModel: FeedViewModel
  private let _appSalesProvider: () -> AppSalesFlowControllerService
  private let _feedListProvider: () -> FeedListFlowControllerService

  private let _embeddedNavigationController = UINavigationController()

  public init(
    viewModel: FeedViewModel,
    appSalesProvider: @autoclosure @escaping () -> AppSalesFlowControllerService,
    feedListProvider: @autoclosure @escaping () -> FeedListFlowControllerService
  ) {
    self._viewModel = viewModel
    self._appSalesProvider = appSalesProvider
    self._feedListProvider = feedListProvider

    super.init(nibName: nil, bundle: nil)

    _embeddedNavigationController.navigationBar.prefersLargeTitles = true

    addContent(_embeddedNavigationController)
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public func start() {
    let feedList = _feedListProvider()
    feedList.delegate = self

    _embeddedNavigationController.setViewControllers([feedList], animated: false)

    feedList.start()
  }

  public func feedListFlowController(_: FeedListFlowControllerService, didSelect appSales: AppSegment) {
    let sales = _appSalesProvider()

    _embeddedNavigationController.pushViewController(sales, animated: true)

    sales.start(segment: appSales)
  }
}
