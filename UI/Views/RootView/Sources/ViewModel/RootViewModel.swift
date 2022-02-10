import Combine

import RepositoryServices

public class RootViewModel: ObservableObject {
  private let _appStateRepository: AppStateRepositoryService

  private let _navigationSubject = CurrentValueSubject<Navigation?, Never>(nil)

  var navigationStream: AnyPublisher<Navigation, Never> {
    _navigationSubject
      .compactMap { $0 }
      .eraseToAnyPublisher()
  }

  private var _cancellable = Set<AnyCancellable>()

  public init(appStateRepository: AppStateRepositoryService) {
    self._appStateRepository = appStateRepository

    _appStateRepository.isWalkthroughFinishedStream()
      .sink { [weak self] isWalkthroughFinished in
        guard let self = self else { return }

        self._navigationSubject.send(isWalkthroughFinished ? .main : .walkthrough)
      }
      .store(in: &_cancellable)
  }
}
