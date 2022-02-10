import SwiftUI

// MARK: - KeyboardTestView

public struct KeyboardTestView: View {
  @ObservedObject private(set) var viewModel: KeyboardTestViewModel

  public var body: some View {
    List {
      Section("TextField 1") {
        TextField("TextField 1", text: $viewModel.text1)
      }
      Section("TextField 2") {
        TextField("TextField 2", text: $viewModel.text2)
      }
      Section("TextField 3") {
        TextField("TextField 3", text: $viewModel.text3)
      }
      Section("TextField 4") {
        TextField("TextField 4", text: $viewModel.text4)
      }
      Section("TextField 5") {
        TextField("TextField 5", text: $viewModel.text5)
      }
      Section("TextField 6") {
        TextField("TextField 6", text: $viewModel.text6)
      }
      Section("TextField 7") {
        TextField("TextField 7", text: $viewModel.text7)
      }
      Section("TextField 8") {
        TextField("TextField 8", text: $viewModel.text8)
      }
      Section("TextField 9") {
        TextField("TextField 9", text: $viewModel.text9)
      }
      Section("TextField 10") {
        TextField("TextField 10", text: $viewModel.text10)
      }
    }
    .onTapGesture {
      UIApplication.shared.sendAction(
        #selector(UIResponder.resignFirstResponder),
        to: nil,
        from: nil,
        for: nil
      )
    }
    .navigationBarTitleDisplayMode(.inline)
    .navigationTitle("Keyboard test")
  }

  public init(viewModel: KeyboardTestViewModel) {
    self.viewModel = viewModel
  }
}

// MARK: - KeyboardTestView_Previews

struct KeyboardTestView_Previews: PreviewProvider {
  private class PreviewViewModel: KeyboardTestViewModel { }

  static var previews: some View {
    NavigationView {
      KeyboardTestView(viewModel: PreviewViewModel())
    }
  }
}
