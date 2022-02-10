import Combine

import Entities
import RepositoryServices

public class WalkthroughViewModel: ObservableObject {
  private let _appStateRepository: AppStateRepositoryService
  private let _preferencesRepository: PreferencesRepositoryService

  @Published var feedLanguage: FeedLanguage?
  @Published var userName: String?

  public init(appStateRepository: AppStateRepositoryService, preferencesRepository: PreferencesRepositoryService) {
    self._appStateRepository = appStateRepository
    self._preferencesRepository = preferencesRepository
  }

  func finishWalkthrough() {
    Task {
      if let feedLanguage = feedLanguage {
        await _preferencesRepository.saveFeedLanguage(feedLanguage)
      }
      if let userName = userName {
        await _preferencesRepository.saveUserName(userName)
      }
      await _appStateRepository.finishWalkthrough()
    }
  }
}
