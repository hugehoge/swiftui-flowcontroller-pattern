import Combine

import Entities

public final class PreviewPreferencesRepository: PreferencesRepositoryService {
  public init() { }

  public func feedLanguageStream() -> AnyPublisher<FeedLanguage, Never> {
    Just(.english).eraseToAnyPublisher()
  }

  public func userNameStream() -> AnyPublisher<String, Never> {
    Just("John Doe").eraseToAnyPublisher()
  }

  public func fetchFeedLanguage() async -> FeedLanguage? {
    .english
  }

  public func fetchUserName() async -> String? {
    "John Doe"
  }

  public func saveFeedLanguage(_ language: FeedLanguage) async {
    print("Call PreferencesRepository.saveFeedLanguage(\(language)")
  }

  public func saveUserName(_ name: String) async {
    print("Call PreferencesRepository.saveUserName(\(name))")
  }
}
