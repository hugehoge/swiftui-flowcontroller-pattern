import UIKit

public protocol SettingsMenuFlowControllerService: UIViewController {
  var delegate: SettingsMenuFlowControllerDelegate? { get set }

  func start()
}
