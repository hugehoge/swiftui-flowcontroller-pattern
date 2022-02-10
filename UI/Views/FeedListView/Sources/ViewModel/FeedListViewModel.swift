import Combine

import Entities
import RepositoryServices

public class FeedListViewModel: ObservableObject {
  private let _feedRepository: FeedRepositoryService
  private let _preferencesRepository: PreferencesRepositoryService

  private let _navigationSubject = PassthroughSubject<Navigation, Never>()

  @Published private(set) var isInLoading = false
  @Published private(set) var hasError = false
  @Published private(set) var newsList: [News] = []
  @Published private(set) var freeAppRanking: [AppInformation] = []
  @Published private(set) var paidAppRanking: [AppInformation] = []

  var navigationSignal: AnyPublisher<Navigation, Never> {
    _navigationSubject.eraseToAnyPublisher()
  }

  public init(feedRepository: FeedRepositoryService, preferencesRepository: PreferencesRepositoryService) {
    self._feedRepository = feedRepository
    self._preferencesRepository = preferencesRepository
  }

  func fetch() {
    Task { @MainActor in
      guard !isInLoading else { return }

      isInLoading = true

      hasError = false
      newsList = []
      freeAppRanking = []
      paidAppRanking = []

      do {
        let language = await _preferencesRepository.fetchFeedLanguage() ?? .english

        (newsList, freeAppRanking, paidAppRanking) = try await (
          _feedRepository.fetchNews(language: language),
          _feedRepository.fetchFreeAppTop15Ranking(language: language),
          _feedRepository.fetchPaidAppTop15Ranking(language: language)
        )
      } catch {
        hasError = true
      }
      isInLoading = false
    }
  }

  func navigate(_ navigation: Navigation) {
    _navigationSubject.send(navigation)
  }
}
