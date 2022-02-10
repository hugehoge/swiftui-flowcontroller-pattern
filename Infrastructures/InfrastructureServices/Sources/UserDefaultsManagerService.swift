import Entities

public protocol UserDefaultsManagerService {
  func fetchFeedLanguage() async -> FeedLanguage?
  func fetchUserName() async -> String?
  func fetchIsWalkthroughFinished() async -> Bool
  func saveFeedLanguage(_ language: FeedLanguage) async
  func saveUserName(_ name: String) async
  func saveIsWalkthroughFinished(_ flag: Bool) async
}
