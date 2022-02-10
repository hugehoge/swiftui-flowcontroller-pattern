import SwiftUI

import Resources

// MARK: - WalkthroughFinishView

public struct WalkthroughFinishView: View {
  @ObservedObject private(set) var viewModel: WalkthroughFinishViewModel

  public var body: some View {
    NavigationView { // For layout purpose only
      ZStack {
        Color(uiColor: Asset.background.color)
          .ignoresSafeArea()

        Button {
          viewModel.navigate(.finish)
        } label: {
          Text("Start")
        }
      }
      .navigationBarTitleDisplayMode(.large)
      .navigationTitle("Start App")
    }
  }

  public init(viewModel: WalkthroughFinishViewModel) {
    self.viewModel = viewModel
  }
}

// MARK: - WalkthroughFinishView_Previews

struct WalkthroughFinishView_Previews: PreviewProvider {
  private class PreviewModel: WalkthroughFinishViewModel { }

  static var previews: some View {
    WalkthroughFinishView(viewModel: PreviewModel())
  }
}
