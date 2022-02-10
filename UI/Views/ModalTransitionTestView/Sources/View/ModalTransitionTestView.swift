import SwiftUI

import Resources

// MARK: - ModalTransitionTestView

public struct ModalTransitionTestView: View {
  @ObservedObject private(set) var viewModel: ModalTransitionTestViewModel

  public var body: some View {
    VStack {
      Button {
        viewModel.navigate(.alert)
      } label: {
        Text("Alert")
      }
      .padding()

      Button {
        viewModel.navigate(.fullScreen)
      } label: {
        Text("Modal .fullScreen")
      }
      .padding()

      Button {
        viewModel.navigate(.pageSheet)
      } label: {
        Text("Modal .pageSheet")
      }
      .padding()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color(uiColor: Asset.background.color))
    .navigationBarTitleDisplayMode(.inline)
    .navigationTitle("Modal transition")
  }

  public init(viewModel: ModalTransitionTestViewModel) {
    self.viewModel = viewModel
  }
}

// MARK: - ModalTransitionTestView_Previews

struct ModalTransitionTestView_Previews: PreviewProvider {
  private class PreviewViewModel: ModalTransitionTestViewModel { }

  static var previews: some View {
    NavigationView {
      ModalTransitionTestView(viewModel: PreviewViewModel())
    }
  }
}
