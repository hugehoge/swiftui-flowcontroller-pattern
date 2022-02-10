import Combine

public protocol AppStateRepositoryService {
  func isWalkthroughFinishedStream() -> AnyPublisher<Bool, Never>
  func finishWalkthrough() async
}
