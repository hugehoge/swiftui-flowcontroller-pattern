import SwiftUI

import RepositoryServices

// MARK: - UserNameSettingView

public struct UserNameSettingView: View {
  @ObservedObject private(set) var viewModel: UserNameSettingViewModel

  public var body: some View {
    List {
      Section {
        TextField(
          "Put your name",
          text: Binding(get: {
            viewModel.userName
          }, set: { text in
            viewModel.updateUserName(text)
          })
        )
          .padding(4)
      } header: {
        Text("User name")
      } footer: {
        Text("For testing keyboard behavior and local data stores.")
      }
      .textCase(nil)
    }
    .navigationBarTitleDisplayMode(.inline)
    .navigationTitle("User name")
  }

  public init(viewModel: UserNameSettingViewModel) {
    self.viewModel = viewModel
  }
}

// MARK: - UserNameSettingView_Previews

struct UserNameSettingView_Previews: PreviewProvider {
  private class PreviewViewModel: UserNameSettingViewModel {
    private let _userName: String

    init(userName: String = "") {
      self._userName = userName

      super.init(preferencesRepository: PreviewPreferencesRepository())
    }

    override var userName: String { _userName }
  }

  static var previews: some View {
    Group {
      NavigationView {
        UserNameSettingView(
          viewModel: PreviewViewModel()
        )
      }

      NavigationView {
        UserNameSettingView(
          viewModel: PreviewViewModel(userName: "Typical Name")
        )
      }
    }
  }
}
