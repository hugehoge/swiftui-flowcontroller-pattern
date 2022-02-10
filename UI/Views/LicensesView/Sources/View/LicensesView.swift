import Combine
import UIKit

import MarkdownView

public final class LicensesView: UIViewController {
  private let _markdownView = MarkdownView()

  private var _cancellable = Set<AnyCancellable>()

  private(set) var viewModel: LicensesViewModel

  public init(viewModel: LicensesViewModel) {
    self.viewModel = viewModel

    super.init(nibName: nil, bundle: nil)

    view.addSubview(_markdownView)
    _markdownView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      _markdownView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      _markdownView.topAnchor.constraint(equalTo: view.topAnchor),
      _markdownView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      _markdownView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])

    updateView()
    viewModel.objectWillChange
      .receive(on: DispatchQueue.main)
      .sink { [weak self] _ in
        self?.updateView()
      }
      .store(in: &_cancellable)
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func updateView() {
    _markdownView.load(markdown: viewModel.markdownText)
  }
}
