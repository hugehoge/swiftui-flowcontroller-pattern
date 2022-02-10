import Entities

public protocol FeedRepositoryService {
  func fetchNews(language: FeedLanguage) async throws -> [News]
  func fetchFreeAppTop15Ranking(language: FeedLanguage) async throws -> [AppInformation]
  func fetchPaidAppTop15Ranking(language: FeedLanguage) async throws -> [AppInformation]
  func fetchFreeAppAllRanking(language: FeedLanguage) async throws -> [AppInformation]
  func fetchPaidAppAllRanking(language: FeedLanguage) async throws -> [AppInformation]
}
