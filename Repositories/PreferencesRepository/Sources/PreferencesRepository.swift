import Combine
import Foundation

import Entities
import InfrastructureServices
import RepositoryServices

public final class PreferencesRepository: PreferencesRepositoryService {
  private let _userDefaultsManager: UserDefaultsManagerService

  private let _feedLanguageSubject = CurrentValueSubject<FeedLanguage?, Never>(nil)
  private let _userNameSubject = CurrentValueSubject<String?, Never>(nil)

  public init(userDefaultsManager: UserDefaultsManagerService) {
    self._userDefaultsManager = userDefaultsManager

    Task {
      _feedLanguageSubject.send(await userDefaultsManager.fetchFeedLanguage())
    }
    Task {
      _userNameSubject.send(await userDefaultsManager.fetchUserName())
    }
  }

  public func feedLanguageStream() -> AnyPublisher<FeedLanguage, Never> {
    _feedLanguageSubject.compactMap { $0 }
      .removeDuplicates()
      .eraseToAnyPublisher()
  }

  public func userNameStream() -> AnyPublisher<String, Never> {
    _userNameSubject.compactMap { $0 }
      .removeDuplicates()
      .eraseToAnyPublisher()
  }

  public func fetchFeedLanguage() async -> FeedLanguage? {
    await withCheckedContinuation { continuation in
      continuation.resume(returning: _feedLanguageSubject.value)
    }
  }

  public func fetchUserName() async -> String? {
    await withCheckedContinuation { continuation in
      continuation.resume(returning: _userNameSubject.value)
    }
  }

  public func saveFeedLanguage(_ language: FeedLanguage) async {
    await _userDefaultsManager.saveFeedLanguage(language)
    _feedLanguageSubject.send(language)
  }

  public func saveUserName(_ name: String) async {
    await _userDefaultsManager.saveUserName(name)
    _userNameSubject.send(name)
  }
}
