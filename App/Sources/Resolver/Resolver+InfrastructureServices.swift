import Foundation

import Resolver

import FeedClient
import InfrastructureServices
import UserDefaultsManager

extension Resolver {
  static func registerInfrastructureServices() {
    register { FeedClient() as FeedClientService }
      .scope(.application)
    register { UserDefaultsManager(userDefaults: UserDefaults.standard) as UserDefaultsManagerService }
      .scope(.application)
  }
}
