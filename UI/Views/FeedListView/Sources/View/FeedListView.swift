import SwiftUI

import Entities
import RepositoryServices
import Resources

// MARK: - FeedListView

public struct FeedListView: View {
  @ObservedObject private(set) var viewModel: FeedListViewModel

  public var body: some View {
    Group {
      if viewModel.isInLoading {
        ProgressView()
      } else if viewModel.hasError {
        Text("Failed to fetch the feed")
      } else {
        _contentList
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color(uiColor: Asset.background.color))
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button {
          viewModel.fetch()
        } label: {
          Image(systemName: "goforward")
        }
      }
    }
    .navigationBarTitleDisplayMode(.large)
    .navigationTitle("Feed")
  }

  private var _contentList: some View {
    ScrollView {
      VStack(spacing: 16) {
        if !viewModel.newsList.isEmpty {
          LatestNewsSection(
            Array(viewModel.newsList.prefix(2))
          ) { feed in
            viewModel.navigate(.news(url: feed.linkURL))
          }
        }
        if !viewModel.freeAppRanking.isEmpty {
          AppRankingSection(
            rankingName: "Free App",
            apps: viewModel.freeAppRanking
          ) {
            viewModel.navigate(.freeAppRanking)
          } openLink: { url in
            viewModel.navigate(.appStore(url: url))
          }
        }
        if !viewModel.paidAppRanking.isEmpty {
          AppRankingSection(
            rankingName: "Paid App",
            apps: viewModel.paidAppRanking
          ) {
            viewModel.navigate(.paidAppRanking)
          } openLink: { url in
            viewModel.navigate(.appStore(url: url))
          }
        }
        if viewModel.newsList.count > 2 {
          AllNewsSection(
            Array(viewModel.newsList.dropFirst(2))
          ) { feed in
            viewModel.navigate(.news(url: feed.linkURL))
          }
        }
      }
    }
  }

  public init(viewModel: FeedListViewModel) {
    self.viewModel = viewModel
  }
}

// MARK: - FeedListView_Previews

struct FeedListView_Previews: PreviewProvider {
  private class PreviewModel: FeedListViewModel {
    private let _isInLoading: Bool
    private let _hasError: Bool

    init(isInLoading: Bool = false, hasError: Bool = false) {
      self._isInLoading = isInLoading
      self._hasError = hasError

      super.init(
        feedRepository: PreviewFeedRepository(),
        preferencesRepository: PreviewPreferencesRepository()
      )
    }

    override var isInLoading: Bool { _isInLoading }
    override var hasError: Bool { _hasError }

    override var newsList: [News] {
      News.previewContentList
    }

    override var freeAppRanking: [AppInformation] {
      AppInformation.previewContentList
    }

    override var paidAppRanking: [AppInformation] {
      AppInformation.previewContentList
    }
  }

  static var previews: some View {
    Group {
      NavigationView {
        FeedListView(viewModel: PreviewModel())
      }
      NavigationView {
        FeedListView(viewModel: PreviewModel(isInLoading: true))
      }
      NavigationView {
        FeedListView(viewModel: PreviewModel(hasError: true))
      }
    }
  }
}
