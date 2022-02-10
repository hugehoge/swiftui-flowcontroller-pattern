import Combine

public class ToolbarTestViewModel: ObservableObject {
  @Published var actionText = ""

  public init() { }

  func printNavigation1Text() {
    actionText = "Navigation 1 tapped."
  }

  func printNavigation2Text() {
    actionText = "Navigation 2 tapped."
  }

  func printBottomLeftText() {
    actionText = "Bottom left tapped."
  }

  func printBottomCenterText() {
    actionText = "Bottom center tapped."
  }

  func printBottomRightText() {
    actionText = "Bottom right tapped."
  }
}
