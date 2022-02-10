import SwiftUI

import Entities
import UIComponents

// MARK: - LatestNewsSection

struct LatestNewsSection: View {
  let newsList: [News]
  private let action: ((News) -> Void)?

  var body: some View {
    VStack(alignment: .leading) {
      Text("Latest News")
        .font(.headline)
        .padding([.leading, .trailing], 16)
      ForEach(0..<newsList.count) { index in
        let news = newsList[index]
        NewsLargeCard(news) {
          action?(news)
        }
      }
      .padding([.leading, .trailing], 16)
      .padding([.top, .bottom], 8)
    }
  }

  init(_ newsList: [News], action: ((News) -> Void)? = nil) {
    self.newsList = newsList
    self.action = action
  }
}

// MARK: - LatestNewsSection_Previews

struct LatestNewsSection_Previews: PreviewProvider {
  static var previews: some View {
    ScrollView {
      LatestNewsSection(News.previewContentList)
    }
    .background(Color.gray)
  }
}
