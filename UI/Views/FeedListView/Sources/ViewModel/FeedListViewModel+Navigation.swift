import Foundation

extension FeedListViewModel {
  enum Navigation: Hashable {
    case news(url: URL)
    case appStore(url: URL)
    case freeAppRanking
    case paidAppRanking
  }
}
