import UIKit

import Resources
import UIServices

public final class LicensesFlowController: UIViewController, LicensesFlowControllerService {
  private let _rootView: LicensesView

  private var _viewModel: LicensesViewModel {
    _rootView.viewModel
  }

  public init(rootView: LicensesView) {
    self._rootView = rootView

    super.init(nibName: nil, bundle: nil)

    navigationItem.largeTitleDisplayMode = .never
    view.backgroundColor = Asset.background.color

    addContent(rootView)
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public func start() {
    _viewModel.markdownText = (try? String(contentsOf: Files.licensesMd.url)) ?? ""
  }
}
