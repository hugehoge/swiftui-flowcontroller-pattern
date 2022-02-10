import SwiftUI

import Entities

// MARK: - AppRankingStack

public struct AppRankingStack: View {
  private let _rankOffset: Int
  private let _firstApp: AppInformation
  private let _secondApp: AppInformation?
  private let _thirdApp: AppInformation?
  private let _openStoreAction: ((URL) -> Void)?

  public var body: some View {
    VStack(alignment: .leading) {
      AppRankingButton(
        _firstApp,
        rank: _rankOffset + 0
      ) {
        _openStoreAction?(_firstApp.storeURL)
      }
      if let secondApp = _secondApp {
        Divider().padding(.leading, 72)
        AppRankingButton(
          secondApp,
          rank: _rankOffset + 1
        ) {
          _openStoreAction?(secondApp.storeURL)
        }
      }
      if let thirdApp = _thirdApp {
        Divider().padding(.leading, 72)
        AppRankingButton(
          thirdApp,
          rank: _rankOffset + 2
        ) {
          _openStoreAction?(thirdApp.storeURL)
        }
      }
      Spacer(minLength: 0)
    }
  }

  public init(
    rankOffset: Int,
    firstApp: AppInformation,
    secondApp: AppInformation? = nil,
    thirdApp: AppInformation? = nil,
    openStoreAction: ((URL) -> Void)? = nil
  ) {
    self._rankOffset = rankOffset
    self._firstApp = firstApp
    self._secondApp = secondApp
    self._thirdApp = thirdApp
    self._openStoreAction = openStoreAction
  }
}

// MARK: - AppRankingStack_Previews

struct AppRankingStack_Previews: PreviewProvider {
  static var previews: some View {
    AppRankingStack(
      rankOffset: 1,
      firstApp: AppInformation.previewContentList[0],
      secondApp: AppInformation.previewContentList[1],
      thirdApp: AppInformation.previewContentList[2]
    )
  }
}
