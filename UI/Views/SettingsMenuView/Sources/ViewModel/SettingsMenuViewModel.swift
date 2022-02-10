import Combine

import RepositoryServices

public class SettingsMenuViewModel: ObservableObject {
  private let _preferencesRepository: PreferencesRepositoryService

  private let _navigationSubject = PassthroughSubject<Navigation, Never>()

  @Published private(set) var userName = ""

  var navigationSignal: AnyPublisher<Navigation, Never> {
    _navigationSubject.eraseToAnyPublisher()
  }

  public init(preferenceRepository: PreferencesRepositoryService) {
    self._preferencesRepository = preferenceRepository

    _preferencesRepository.userNameStream()
      .assign(to: &$userName)
  }

  func navigate(_ navigation: Navigation) {
    _navigationSubject.send(navigation)
  }
}
