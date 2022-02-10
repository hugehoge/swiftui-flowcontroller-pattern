import Combine

import Entities
import RepositoryServices

public class AppSalesViewModel: ObservableObject {
  private let _feedRepository: FeedRepositoryService
  private let _preferencesRepository: PreferencesRepositoryService

  private let _navigationSubject = PassthroughSubject<Navigation, Never>()

  @Published public var segment: AppSegment?

  @Published private(set) var isInLoading = false
  @Published private(set) var hasError = false
  @Published private(set) var freeApps: [AppInformation] = []
  @Published private(set) var paidApps: [AppInformation] = []

  var navigationSignal: AnyPublisher<Navigation, Never> {
    _navigationSubject.eraseToAnyPublisher()
  }

  public init(feedRepository: FeedRepositoryService, preferencesRepository: PreferencesRepositoryService) {
    self._feedRepository = feedRepository
    self._preferencesRepository = preferencesRepository
  }

  func fetch() {
    Task { @MainActor in
      isInLoading = true

      hasError = false
      freeApps = []
      paidApps = []

      let language = await _preferencesRepository.fetchFeedLanguage() ?? .english
      do {
        (freeApps, paidApps) = try await (
          _feedRepository.fetchFreeAppAllRanking(language: language),
          _feedRepository.fetchPaidAppAllRanking(language: language)
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
