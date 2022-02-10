import SwiftUI

import Resources
import UIComponents

// MARK: - WalkthroughIntroView

public struct WalkthroughIntroView: View {
  @ObservedObject private(set) var viewModel: WalkthroughIntroViewModel

  public var body: some View {
    NavigationView { // For layout purpose only
      VStack {
        HStack {
          Text(
            """
            This is a Proof-of-Concept app for iOS app architecture using SwiftUI + FlowController pattern.
            """
          )
          Spacer(minLength: 0)
        }
        .padding()

        HStack {
          Text("App has features below:")
          Spacer(minLength: 0)
        }
        .padding([.leading, .trailing])
        .padding([.bottom], 8)

        HStack {
          VStack(alignment: .leading, spacing: 4) {
            BulletPointText("Walkthrough with UIPageViewController")
            BulletPointText("Main view with UITabBarController")
            BulletPointText("Feed view and Settings view with UINavigationController")
            BulletPointText("Feed view shows the feed for Apple Newsroom and App sales")
            BulletPointText("Settings view has some views for feature tests")
          }
          Spacer(minLength: 0)
        }
        .padding([.leading, .trailing])

        Spacer()
      }
      .background(Color(uiColor: Asset.background.color))
      .navigationBarTitleDisplayMode(.large)
      .navigationTitle("About")
    }
  }

  public init(viewModel: WalkthroughIntroViewModel) {
    self.viewModel = viewModel
  }
}

// MARK: - WalkthroughIntroView_Previews

struct WalkthroughIntroView_Previews: PreviewProvider {
  private class PreviewModel: WalkthroughIntroViewModel { }

  static var previews: some View {
    WalkthroughIntroView(viewModel: PreviewModel())
  }
}
