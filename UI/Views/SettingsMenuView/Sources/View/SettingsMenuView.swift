import SwiftUI

import Entities
import RepositoryServices
import UIComponents

// MARK: - SettingsMenuView

public struct SettingsMenuView: View {
  @ObservedObject private(set) var viewModel: SettingsMenuViewModel

  public var body: some View {
    List {
      ForEach(SettingsMenu.Section.allCases, id: \.self) { section in
        Section {
          ForEach(section.rows, id: \.self) { row in
            switch row.type {
            case .user:
              HStack {
                Image(systemName: "person.circle.fill")
                  .resizable()
                  .foregroundColor(.secondary)
                  .frame(width: 48, height: 48)
                  .padding([.top, .trailing, .bottom], 8)
                Text(viewModel.userName)
              }

            case .transition:
              NavigationLinkButton(row.title) {
                viewModel.navigate(.menu(row: row))
              }

            case .version:
              HStack {
                Text("Version")
                Spacer()
                Text("1.0.0").foregroundColor(.secondary)
              }
            }
          }
        } header: {
          if let title = section.title {
            Text(title)
          }
        }
        .textCase(nil)
      }
    }
    .listStyle(.insetGrouped)
    .navigationTitle("Settings")
  }

  public init(viewModel: SettingsMenuViewModel) {
    self.viewModel = viewModel
  }
}

// MARK: - SettingsMenuView_Previews

struct SettingsMenuView_Previews: PreviewProvider {
  private class PreviewModel: SettingsMenuViewModel {
    private let _userName: String

    override var userName: String { _userName }

    init(userName: String = "") {
      self._userName = userName

      super.init(preferenceRepository: PreviewPreferencesRepository())
    }
  }

  static var previews: some View {
    NavigationView {
      SettingsMenuView(viewModel: PreviewModel(userName: "John Doe"))
    }
  }
}
