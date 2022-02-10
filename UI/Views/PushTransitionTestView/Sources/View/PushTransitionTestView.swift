import SwiftUI

// MARK: - PushTransitionTestView

public struct PushTransitionTestView: View {
  @ObservedObject private(set) var viewModel: PushTransitionTestViewModel

  public var body: some View {
    List {
      Section {
        TextField("Forward text", text: $viewModel.forwardText)
      } header: {
        Text("Forward text")
      }
      .textCase(nil)
    }
    .navigationBarTitleDisplayMode(.inline)
    .navigationTitle("Push transition")
    .toolbar {
      ToolbarItemGroup(placement: .bottomBar) {
        Button {
          viewModel.navigate(.popToRoot)
        } label: {
          Text("Pop to root")
        }
        Spacer()
        Button {
          viewModel.navigate(.next)
        } label: {
          Text("Next")
        }
        Spacer()
      }
    }
  }

  public init(viewModel: PushTransitionTestViewModel) {
    self.viewModel = viewModel
  }
}

// MARK: - PushTransitionTestView_Previews

struct PushTransitionTestView_Previews: PreviewProvider {
  private class PreviewViewModel: PushTransitionTestViewModel { }

  static var previews: some View {
    NavigationView {
      PushTransitionTestView(viewModel: PreviewViewModel())
    }
  }
}
