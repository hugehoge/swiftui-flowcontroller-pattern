import Entities

public protocol FeedClientService {
  func fetchNews(language: FeedLanguage) async throws -> [News]
  func fetchFreeAppRanking(language: FeedLanguage, limit: Int) async throws -> [AppInformation]
  func fetchPaidAppRanking(language: FeedLanguage, limit: Int) async throws -> [AppInformation]
}
