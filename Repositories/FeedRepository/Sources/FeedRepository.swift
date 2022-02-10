import Entities
import InfrastructureServices
import RepositoryServices

public final class FeedRepository: FeedRepositoryService {
  private let _feedClient: FeedClientService

  public init(feedClient: FeedClientService) {
    self._feedClient = feedClient
  }

  public func fetchNews(language: FeedLanguage) async throws -> [News] {
    try await _feedClient.fetchNews(language: language)
  }

  public func fetchFreeAppTop15Ranking(language: FeedLanguage) async throws -> [AppInformation] {
    try await _feedClient.fetchFreeAppRanking(language: language, limit: 15)
  }

  public func fetchPaidAppTop15Ranking(language: FeedLanguage) async throws -> [AppInformation] {
    try await _feedClient.fetchPaidAppRanking(language: language, limit: 15)
  }

  public func fetchFreeAppAllRanking(language: FeedLanguage) async throws -> [AppInformation] {
    try await _feedClient.fetchFreeAppRanking(language: language, limit: 50)
  }

  public func fetchPaidAppAllRanking(language: FeedLanguage) async throws -> [AppInformation] {
    try await _feedClient.fetchPaidAppRanking(language: language, limit: 50)
  }
}
