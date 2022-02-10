import Combine

import Entities

public protocol PreferencesRepositoryService {
  func feedLanguageStream() -> AnyPublisher<FeedLanguage, Never>
  func userNameStream() -> AnyPublisher<String, Never>
  func fetchFeedLanguage() async -> FeedLanguage?
  func fetchUserName() async -> String?
  func saveFeedLanguage(_ language: FeedLanguage) async
  func saveUserName(_ name: String) async
}
