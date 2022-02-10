import Entities

public final class PreviewFeedRepository: FeedRepositoryService {
  public init() { }

  public func fetchNews(language _: FeedLanguage) async throws -> [News] {
    News.previewContentList
  }

  public func fetchFreeAppTop15Ranking(language _: FeedLanguage) async throws -> [AppInformation] {
    AppInformation.previewContentList
  }

  public func fetchPaidAppTop15Ranking(language _: FeedLanguage) async throws -> [AppInformation] {
    AppInformation.previewContentList
  }

  public func fetchFreeAppAllRanking(language _: FeedLanguage) async throws -> [AppInformation] {
    AppInformation.previewContentList
  }

  public func fetchPaidAppAllRanking(language _: FeedLanguage) async throws -> [AppInformation] {
    AppInformation.previewContentList
  }
}
