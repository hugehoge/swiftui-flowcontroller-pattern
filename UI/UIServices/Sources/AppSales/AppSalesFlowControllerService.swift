import UIKit

import Entities

public protocol AppSalesFlowControllerService: UIViewController {
  func start(segment: AppSegment)
}
