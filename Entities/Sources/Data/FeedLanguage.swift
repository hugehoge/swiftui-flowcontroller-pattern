import Foundation

public enum FeedLanguage: String {
  case english
  case japanese

  public var title: String {
    switch self {
    case .english:
      return "English"

    case .japanese:
      return "Japanese"
    }
  }
}
