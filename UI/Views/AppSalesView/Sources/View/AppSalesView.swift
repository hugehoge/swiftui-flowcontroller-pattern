import SwiftUI

import Entities
import RepositoryServices
import Resources
import UIComponents

// MARK: - AppSalesView

public struct AppSalesView: View {
  @ObservedObject private(set) var viewModel: AppSalesViewModel

  public var body: some View {
    VStack {
      _segmentedControl
        .padding()

      if viewModel.isInLoading {
        Spacer()
        ProgressView()
        Spacer()
      } else if viewModel.hasError {
        Spacer()
        Text("Failed to fetch the feed")
        Spacer()
      } else if let segment = viewModel.segment {
        switch segment {
        case .freeApp:
          _freeAppList

        case .paidApp:
          _paidAppList
        }
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
    .navigationBarTitleDisplayMode(.inline)
    .navigationTitle("App Sales")
  }

  private var _segmentedControl: some View {
    Picker(
      "App Segment",
      selection: Binding(get: {
        if viewModel.segment == .freeApp {
          return 0
        } else if viewModel.segment == .paidApp {
          return 1
        } else {
          return -1
        }
      }, set: { tag in
        viewModel.segment = (tag == 0) ? .freeApp : .paidApp
      })
    ) {
      Text(AppSegment.freeApp.title).tag(0)
      Text(AppSegment.paidApp.title).tag(1)
    }
    .pickerStyle(.segmented)
    .frame(width: 280)
  }

  private var _freeAppList: some View {
    ScrollView {
      LazyVStack {
        if !viewModel.freeApps.isEmpty {
          ForEach(0..<viewModel.freeApps.count) { index in
            let app = viewModel.freeApps[index]

            VStack(alignment: .leading) {
              AppRankingButton(app, rank: index + 1) {
                viewModel.navigate(.appStore(url: app.storeURL))
              }

              if index != viewModel.freeApps.count - 1 {
                Divider().padding(.leading, 72)
              }
            }
            .padding([.leading, .trailing], 24)
          }
        }
      }
    }
  }

  private var _paidAppList: some View {
    ScrollView {
      LazyVStack {
        if !viewModel.paidApps.isEmpty {
          ForEach(0..<viewModel.paidApps.count) { index in
            let app = viewModel.paidApps[index]

            VStack(alignment: .leading) {
              AppRankingButton(app, rank: index + 1) {
                viewModel.navigate(.appStore(url: app.storeURL))
              }

              if index != viewModel.paidApps.count - 1 {
                Divider().padding(.leading, 72)
              }
            }
            .padding([.leading, .trailing], 24)
          }
        }
      }
    }
  }

  public init(viewModel: AppSalesViewModel) {
    self.viewModel = viewModel
  }
}

// MARK: - AppSalesView_Previews

struct AppSalesView_Previews: PreviewProvider {
  private class PreviewViewModel: AppSalesViewModel {
    private let _isInLoading: Bool
    private let _hasError: Bool
    private let _freeApps: [AppInformation]
    private let _paidApps: [AppInformation]

    init(
      segment: AppSegment?,
      isInLoading: Bool = false,
      hasError: Bool = false,
      freeApps: [AppInformation] = AppInformation.previewContentList,
      paidApps: [AppInformation] = AppInformation.previewContentList
    ) {
      self._isInLoading = isInLoading
      self._hasError = hasError
      self._freeApps = freeApps
      self._paidApps = paidApps

      super.init(
        feedRepository: PreviewFeedRepository(),
        preferencesRepository: PreviewPreferencesRepository()
      )

      self.segment = segment
    }

    override var isInLoading: Bool { _isInLoading }
    override var hasError: Bool { _hasError }
    override var freeApps: [AppInformation] { _freeApps }
    override var paidApps: [AppInformation] { _paidApps }
  }

  static var previews: some View {
    Group {
      NavigationView {
        AppSalesView(viewModel: PreviewViewModel(segment: .freeApp))
      }
      NavigationView {
        AppSalesView(
          viewModel: PreviewViewModel(segment: .freeApp, isInLoading: true)
        )
      }
      NavigationView {
        AppSalesView(
          viewModel: PreviewViewModel(segment: .freeApp, hasError: true)
        )
      }
    }
  }
}
