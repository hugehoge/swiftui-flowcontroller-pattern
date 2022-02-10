import Resolver

import AppStateRepository
import FeedRepository
import PreferencesRepository
import RepositoryServices

extension Resolver {
  static func registerRepositoryServices() {
    register { AppStateRepository(userDefaultsManager: resolve()) as AppStateRepositoryService }
      .scope(.application)
    register { FeedRepository(feedClient: resolve()) as FeedRepositoryService }
      .scope(.application)
    register { PreferencesRepository(userDefaultsManager: resolve()) as PreferencesRepositoryService }
      .scope(.application)
  }
}
