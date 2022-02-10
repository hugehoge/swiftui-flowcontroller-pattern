import Combine
import Foundation

import Entities
import RepositoryServices

public class FeedLanguageSettingViewModel: ObservableObject {
  private let _preferencesRepository: PreferencesRepositoryService

  @Published private(set) var language: FeedLanguage = .english

  public init(preferencesRepository: PreferencesRepositoryService) {
    self._preferencesRepository = preferencesRepository

    _preferencesRepository.feedLanguageStream()
      .receive(on: DispatchQueue.main)
      .assign(to: &$language)
  }

  func updateFeedLanguage(_ language: FeedLanguage) {
    Task {
      await self._preferencesRepository.saveFeedLanguage(language)
    }
  }
}
