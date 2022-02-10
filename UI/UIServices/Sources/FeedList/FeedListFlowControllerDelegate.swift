import Entities

public protocol FeedListFlowControllerDelegate: AnyObject {
  func feedListFlowController(_ flowController: FeedListFlowControllerService, didSelect appSales: AppSegment)
}
