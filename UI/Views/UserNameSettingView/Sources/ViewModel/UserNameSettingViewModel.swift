import Combine
import Foundation

import RepositoryServices

public class UserNameSettingViewModel: ObservableObject {
  private let _preferencesRepository: PreferencesRepositoryService

  @Published private(set) var userName = ""

  public init(preferencesRepository: PreferencesRepositoryService) {
    self._preferencesRepository = preferencesRepository

    _preferencesRepository.userNameStream()
      .receive(on: DispatchQueue.main)
      .assign(to: &$userName)
  }

  func updateUserName(_ name: String) {
    Task {
      await _preferencesRepository.saveUserName(name)
    }
  }
}
