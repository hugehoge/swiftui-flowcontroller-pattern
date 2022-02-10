import Foundation

import Entities
import InfrastructureServices

public final class UserDefaultsManager: UserDefaultsManagerService {
  private let _userDefaults: UserDefaults

  public init(userDefaults: UserDefaults) {
    self._userDefaults = userDefaults
  }

  public func fetchFeedLanguage() async -> FeedLanguage? {
    await withCheckedContinuation { continuation in
      let rawValue = _userDefaults.value(forKey: UserDefaultsKey.feedLanguage.rawValue) as? String
      let language = rawValue.flatMap { FeedLanguage(rawValue: $0) }
      continuation.resume(returning: language)
    }
  }

  public func fetchUserName() async -> String? {
    await withCheckedContinuation { continuation in
      let value = _userDefaults.value(forKey: UserDefaultsKey.userName.rawValue) as? String
      continuation.resume(returning: value)
    }
  }

  public func fetchIsWalkthroughFinished() async -> Bool {
    await withCheckedContinuation { continuation in
      let value = _userDefaults.bool(forKey: UserDefaultsKey.isWalkthroughFinished.rawValue)
      continuation.resume(returning: value)
    }
  }

  public func saveFeedLanguage(_ language: FeedLanguage) async {
    await withCheckedContinuation { (continuation: CheckedContinuation<Void, Never>) in
      _userDefaults.set(language.rawValue, forKey: UserDefaultsKey.feedLanguage.rawValue)
      continuation.resume()
    }
  }

  public func saveUserName(_ name: String) async {
    await withCheckedContinuation { (continuation: CheckedContinuation<Void, Never>) in
      _userDefaults.set(name, forKey: UserDefaultsKey.userName.rawValue)
      continuation.resume()
    }
  }

  public func saveIsWalkthroughFinished(_ flag: Bool) async {
    await withCheckedContinuation { (continuation: CheckedContinuation<Void, Never>) in
      _userDefaults.set(flag, forKey: UserDefaultsKey.isWalkthroughFinished.rawValue)
      continuation.resume()
    }
  }
}
