import SwiftUI

// MARK: - ToolbarTestView

public struct ToolbarTestView: View {
  @ObservedObject private(set) var viewModel: ToolbarTestViewModel

  public var body: some View {
    List {
      Section("Action") {
        Text(viewModel.actionText)
      }
    }
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button {
          viewModel.printNavigation1Text()
        } label: {
          Image(systemName: "1.circle")
        }
      }

      ToolbarItem(placement: .navigationBarTrailing) {
        Button {
          viewModel.printNavigation2Text()
        } label: {
          Image(systemName: "2.circle")
        }
      }

      ToolbarItemGroup(placement: .bottomBar) {
        Button("Left") {
          viewModel.printBottomLeftText()
        }
        Spacer()
        Button("Center") {
          viewModel.printBottomCenterText()
        }
        Spacer()
        Button("Right") {
          viewModel.printBottomRightText()
        }
      }
    }
    .navigationBarTitleDisplayMode(.inline)
    .navigationTitle("Toolbar test")
  }

  public init(viewModel: ToolbarTestViewModel) {
    self.viewModel = viewModel
  }
}

// MARK: - ToolbarTestView_Previews

struct ToolbarTestView_Previews: PreviewProvider {
  private class PreviewViewModel: ToolbarTestViewModel { }

  static var previews: some View {
    NavigationView {
      ToolbarTestView(viewModel: PreviewViewModel())
    }
  }
}
