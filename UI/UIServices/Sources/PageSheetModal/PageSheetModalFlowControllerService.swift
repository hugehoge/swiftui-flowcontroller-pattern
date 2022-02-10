import UIKit

public protocol PageSheetModalFlowControllerService: UIViewController {
  var delegate: PageSheetModalFlowControllerDelegate? { get set }

  func start()
}
