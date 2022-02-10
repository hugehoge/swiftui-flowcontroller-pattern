import SwiftUI

import Entities
import RepositoryServices
import UIComponents

// MARK: - FeedLanguageSettingView

public struct FeedLanguageSettingView: View {
  @ObservedObject private(set) var viewModel: FeedLanguageSettingViewModel

  private let _languages: [FeedLanguage] = [.english, .japanese]

  public var body: some View {
    List {
      Section {
        RadioButtonGroup(
          _languages.map(\.title),
          selectedIndex: Binding(get: {
            _languages.firstIndex(of: viewModel.language)
          }, set: { selectedIndex in
            if let selectedIndex = selectedIndex {
              viewModel.updateFeedLanguage(_languages[selectedIndex])
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
    }
    .navigationBarTitleDisplayMode(.inline)
    .navigationTitle("Feed language")
  }

  public init(viewModel: FeedLanguageSettingViewModel) {
    self.viewModel = viewModel
  }
}

// MARK: - FeedLanguageSettingView_Previews

struct FeedLanguageSettingView_Previews: PreviewProvider {
  private class PreviewViewModel: FeedLanguageSettingViewModel {
    init() {
      super.init(preferencesRepository: PreviewPreferencesRepository())
    }
  }

  static var previews: some View {
    Group {
      NavigationView {
        FeedLanguageSettingView(viewModel: PreviewViewModel())
      }
    }
  }
}
