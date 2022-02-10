import Combine

public class WalkthroughFinishViewModel: ObservableObject {
  private let _navigationSubject = PassthroughSubject<Navigation, Never>()

  var navigationSignal: AnyPublisher<Navigation, Never> {
    _navigationSubject.eraseToAnyPublisher()
  }

  public init() { }

  func navigate(_ navigation: Navigation) {
    _navigationSubject.send(navigation)
  }
}
