import SwiftUI

import Kingfisher

import Entities

// MARK: - AppIcon

public struct AppIcon: View {
  private let _url: URL

  public var body: some View {
    KFImage(_url)
      .cacheMemoryOnly()
      .placeholder {
        Color.gray
      }
      .resizable()
      .frame(width: 72, height: 72)
      .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
      .fixedSize()
  }

  public init(url: URL) {
    self._url = url
  }
}

// MARK: - AppIcon_Previews

struct AppIcon_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      ForEach(AppInformation.previewContentList, id: \.self) { content in
        AppIcon(url: content.iconURL)
          .previewLayout(.fixed(width: 200, height: 100))
      }
    }
  }
}
