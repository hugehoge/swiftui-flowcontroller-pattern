import Combine

import Entities

public class WalkthroughSettingsViewModel: ObservableObject {
  @Published var feedLanguage: FeedLanguage = .english
  @Published var userName = ""

  var feedLanguageStream: AnyPublisher<FeedLanguage, Never> {
    $feedLanguage.eraseToAnyPublisher()
  }

  var userNameStream: AnyPublisher<String, Never> {
    $userName.eraseToAnyPublisher()
  }

  public init() { }
}
