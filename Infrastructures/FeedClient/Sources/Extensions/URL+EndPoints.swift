import Foundation

import Entities

extension URL {
  static func newsFeed(language: FeedLanguage) -> URL {
    switch language {
    case .english:
      // swiftlint:disable:next force_unwrapping
      return URL(string: "https://www.apple.com/newsroom/rss-feed.rss")!

    case .japanese:
      // swiftlint:disable:next force_unwrapping
      return URL(string: "https://www.apple.com/jp/newsroom/rss-feed.rss")!
    }
  }

  static func freeAppRankingFeed(language: FeedLanguage, limit: Int) -> URL {
    switch language {
    case .english:
      // swiftlint:disable:next force_unwrapping
      return URL(string: "https://itunes.apple.com/rss/topfreeapplications/limit=\(limit)/xml")!

    case .japanese:
      // swiftlint:disable:next force_unwrapping
      return URL(string: "https://itunes.apple.com/jp/rss/topfreeapplications/limit=\(limit)/xml")!
    }
  }

  static func paidAppRankingFeed(language: FeedLanguage, limit: Int) -> URL {
    switch language {
    case .english:
      // swiftlint:disable:next force_unwrapping
      return URL(string: "https://itunes.apple.com/rss/toppaidapplications/limit=\(limit)/xml")!

    case .japanese:
      // swiftlint:disable:next force_unwrapping
      return URL(string: "https://itunes.apple.com/jp/rss/toppaidapplications/limit=\(limit)/xml")!
    }
  }
}
