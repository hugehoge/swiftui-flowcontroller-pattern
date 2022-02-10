import UIKit

extension UIViewController {
  public func addContent(_ viewController: UIViewController) {
    addChild(viewController)
    view.addSubview(viewController.view)
    viewController.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      viewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      viewController.view.topAnchor.constraint(equalTo: view.topAnchor),
      viewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      viewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])
    viewController.didMove(toParent: self)
  }

  public func removeContent(_ viewController: UIViewController) {
    viewController.willMove(toParent: nil)
    viewController.view.removeFromSuperview()
    viewController.removeFromParent()
  }

  public func removeAllContentViewController() {
    for child in children.reversed() {
      removeContent(child)
    }
  }
}
