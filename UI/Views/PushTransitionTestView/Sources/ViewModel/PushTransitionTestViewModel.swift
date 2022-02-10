import Combine

public class PushTransitionTestViewModel: ObservableObject {
  private let _navigationSubject = PassthroughSubject<Navigation, Never>()

  @Published var forwardText = ""

  var navigationSignal: AnyPublisher<Navigation, Never> {
    _navigationSubject.eraseToAnyPublisher()
  }

  public init() { }

  func navigate(_ navigation: Navigation) {
    _navigationSubject.send(navigation)
  }
}
