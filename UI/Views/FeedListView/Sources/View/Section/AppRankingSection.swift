import SwiftUI

import Snappable

import Entities
import UIComponents

// MARK: - AppRankingSection

struct AppRankingSection: View {
  let rankingName: String
  let apps: [AppInformation]
  private let showAllAction: (() -> Void)?
  private let openStoreAction: ((URL) -> Void)?

  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        Text(rankingName)
          .font(.headline)
          .padding([.leading, .trailing], 16)
        Spacer()
        Button {
          showAllAction?()
        } label: {
          Text("Show All")
            .font(.body)
            .padding([.leading, .trailing], 16)
        }
      }

      _carousel
        .padding([.top, .bottom], 8)
    }
  }

  private var _carousel: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      if !apps.isEmpty {
        HStack(spacing: 0) {
          ForEach(0..<(apps.count + 2) / 3) { index in
            let offset = index * 3

            HStack(spacing: 0) {
              Spacer(minLength: 16)
              AppRankingStack(
                rankOffset: offset + 1,
                firstApp: apps[offset],
                secondApp: apps.indices.contains(offset + 1) ? apps[offset + 1] : nil,
                thirdApp: apps.indices.contains(offset + 2) ? apps[offset + 2] : nil
              ) { url in
                openStoreAction?(url)
              }
              .frame(width: UIScreen.main.bounds.width - 48) // FIXME: Avoid using UIScreen.main.bounds
            }
            .snapID(index)
          }

          Spacer(minLength: 32)
        }
      }
    }
    .snappable(alignment: .leading)
  }

  init(
    rankingName: String,
    apps: [AppInformation],
    showAll: (() -> Void)? = nil,
    openLink: ((URL) -> Void)? = nil
  ) {
    self.rankingName = rankingName
    self.apps = apps
    self.showAllAction = showAll
    self.openStoreAction = openLink
  }
}

// MARK: - AppRankingSection_Previews

struct AppRankingSection_Previews: PreviewProvider {
  static var previews: some View {
    AppRankingSection(rankingName: "Free App", apps: AppInformation.previewContentList)
  }
}
