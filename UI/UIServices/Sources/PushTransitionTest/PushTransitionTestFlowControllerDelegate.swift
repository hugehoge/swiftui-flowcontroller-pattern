public protocol PushTransitionTestFlowControllerDelegate: AnyObject {
  func pushTransitionTestFlowController(
    _ flowController: PushTransitionTestFlowControllerService,
    nextWith forwardText: String
  )
  func pushTransitionTestFlowControllerPopToRoot(_ flowController: PushTransitionTestFlowControllerService)
}
