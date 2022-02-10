import SwiftUI

// MARK: - FullScreenModalView

public struct FullScreenModalView: View {
  @ObservedObject private(set) var viewModel: FullScreenModalViewModel

  public var body: some View {
    NavigationView { // Just for the layout
      Button {
        viewModel.navigate(.dismiss)
      } label: {
        Text("Dismiss")
      }
      .navigationBarTitleDisplayMode(.inline)
      .navigationTitle("Modal .fullScreen")
    }
  }

  public init(viewModel: FullScreenModalViewModel) {
    self.viewModel = viewModel
  }
}

// MARK: - FullScreenModalView_Previews

struct FullScreenModalView_Previews: PreviewProvider {
  private class PreviewViewModel: FullScreenModalViewModel { }

  static var previews: some View {
    FullScreenModalView(viewModel: PreviewViewModel())
  }
}
