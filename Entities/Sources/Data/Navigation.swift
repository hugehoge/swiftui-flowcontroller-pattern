import Foundation

public enum Navigation: Hashable {
  public enum AppSalesView: Hashable {
    case appStore(url: URL)
  }

  public enum FeedListView: Hashable {
    case news(url: URL)
    case appStore(url: URL)
    case freeAppRanking
    case paidAppRanking
  }

  public enum FullScreenModalView {
    case dismiss
  }

  public enum ModalTransitionTestView {
    case alert
    case fullScreen
    case pageSheet
  }

  public enum PageSheetModalView {
    case dismiss
  }

  public enum PushTransitionTestView {
    case next
    case popToRoot
  }

  public enum RootView {
    case main
    case walkthrough
  }

  public enum SettingsMenuView: Hashable {
    case menu(row: SettingsMenu.Row)
  }

  public enum WalkthroughFinishView {
    case finish
  }
}
