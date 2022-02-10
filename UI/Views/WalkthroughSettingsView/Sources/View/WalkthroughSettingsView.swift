import SwiftUI

import Entities
import Resources
import UIComponents

// MARK: - WalkthroughSettingsView

public struct WalkthroughSettingsView: View {
  @ObservedObject private(set) var viewModel: WalkthroughSettingsViewModel

  private let _languages: [FeedLanguage] = [.english, .japanese]

  public var body: some View {
    NavigationView { // For layout purpose only
      List {
        Section {
          RadioButtonGroup(
            _languages.map(\.title),
            selectedIndex: Binding(get: {
              _languages.firstIndex(of: viewModel.feedLanguage)
            }, set: { selectedIndex in
              if let selectedIndex = selectedIndex {
                viewModel.feedLanguage = _languages[selectedIndex]
              }
            })
          )
            .padding([.top, .bottom], 4)
        } header: {
          Text("Feed language")
        } footer: {
          Text("Language setting in the feed source.")
        }
        .textCase(nil)

        Section {
          TextField(
            "Put your name",
            text: $viewModel.userName
          )
            .padding(4)
        } header: {
          Text("User name")
        } footer: {
          Text("For testing keyboard behavior and local data stores.")
        }
        .textCase(nil)
      }
      .listStyle(.insetGrouped)
      .navigationBarTitleDisplayMode(.large)
      .navigationTitle("Settings")
    }
  }

  public init(viewModel: WalkthroughSettingsViewModel) {
    self.viewModel = viewModel
  }
}

// MARK: - WalkthroughSettingsView_Previews

struct WalkthroughSettingsView_Previews: PreviewProvider {
  private class PreviewModel: WalkthroughSettingsViewModel {
    init(feedLanguage: FeedLanguage, userName: String) {
      super.init()

      self.feedLanguage = feedLanguage
      self.userName = userName
    }
  }

  static var previews: some View {
    WalkthroughSettingsView(
      viewModel: PreviewModel(
        feedLanguage: .english,
        userName: ""
      )
    )
  }
}
