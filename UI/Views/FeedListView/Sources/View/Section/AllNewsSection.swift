import SwiftUI

import Snappable

import Entities
import UIComponents

// MARK: - AllNewsSection

struct AllNewsSection: View {
  let newsList: [News]
  let action: ((News) -> Void)?

  var body: some View {
    VStack(alignment: .leading) {
      Text("All News")
        .font(.headline)
        .padding([.leading, .trailing], 16)
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 0) {
          ForEach(0..<newsList.count) { index in
            let news = newsList[index]
            HStack(spacing: 0) {
              Spacer(minLength: 16)
              NewsSmallCard(news) {
                action?(news)
              }
            }
            .snapID(index)
          }
          Spacer(minLength: 64)
        }
      }
      .snappable(alignment: .leading, mode: .afterScrolling)
      .padding([.top, .bottom], 8)
    }
  }

  init(_ newsList: [News], action: ((News) -> Void)? = nil) {
    self.newsList = newsList
    self.action = action
  }
}

// MARK: - AllNewsSection_Previews

struct AllNewsSection_Previews: PreviewProvider {
  static var previews: some View {
    AllNewsSection(News.previewContentList)
  }
}
