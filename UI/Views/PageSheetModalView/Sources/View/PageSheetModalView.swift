import SwiftUI

// MARK: - PageSheetModalView

public struct PageSheetModalView: View {
  @ObservedObject private(set) var viewModel: PageSheetModalViewModel

  public var body: some View {
    NavigationView { // Just for the layout
      Button {
        viewModel.navigate(.dismiss)
      } label: {
        Text("Dismiss")
      }
      .navigationBarTitleDisplayMode(.inline)
      .navigationTitle("Modal .pageSheet")
    }
  }

  public init(viewModel: PageSheetModalViewModel) {
    self.viewModel = viewModel
  }
}

// MARK: - PageSheetModalView_Previews

struct PageSheetModalView_Previews: PreviewProvider {
  private class PreviewViewModel: PageSheetModalViewModel { }

  static var previews: some View {
    PageSheetModalView(viewModel: PreviewViewModel())
  }
}
