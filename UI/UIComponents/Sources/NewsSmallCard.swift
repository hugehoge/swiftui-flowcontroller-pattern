import SwiftUI

import Kingfisher

import Entities

// MARK: - _NewsSmallCardButtonStyle

private struct _NewsSmallCardButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
      .animation(.easeInOut, value: configuration.isPressed ? 0.95 : 1.0)
  }
}

// MARK: - NewsSmallCard

public struct NewsSmallCard: View {
  private let _news: News
  private let _action: (() -> Void)?

  public var body: some View {
    Button {
      _action?()
    } label: {
      _buttonLabel
    }
    .buttonStyle(_NewsSmallCardButtonStyle())
  }

  private var _buttonLabel: some View {
    VStack(spacing: 8) {
      ZStack(alignment: .topLeading) {
        KFImage(_news.imageURL)
          .cacheMemoryOnly()
          .placeholder {
            Color.gray
          }
          .resizable()
          .aspectRatio(1192 / 626, contentMode: .fit)

        LinearGradient(
          colors: [
            Color.black.opacity(0.5),
            Color.black.opacity(0.3),
            Color.black.opacity(0.0),
          ],
          startPoint: .top,
          endPoint: .bottom
        )
          .frame(height: 40)

        Text(_news.category)
          .foregroundColor(.white)
          .font(.footnote)
          .fontWeight(.bold)
          .lineLimit(1)
          .padding([.leading, .trailing], 16)
          .padding(.top, 8)
      }

      ZStack(alignment: .topLeading) {
        // For fixing the height
        Text("\n\n")
          .font(.subheadline)
          .lineLimit(3)

        HStack {
          Text(_news.title)
            .font(.subheadline)
            .lineLimit(3)
          Spacer(minLength: 0)
        }
      }
      .padding([.leading, .trailing], 16)
      .padding(.bottom, 8)
    }
    .frame(width: 240, height: 200)
    .background(Color(uiColor: .secondarySystemGroupedBackground))
    .cornerRadius(16)
  }

  public init(_ news: News, action: (() -> Void)? = nil) {
    self._news = news
    self._action = action
  }
}

// MARK: - NewsSmallCard_Previews

struct NewsSmallCard_Previews: PreviewProvider {
  static var previews: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(spacing: 16) {
        ForEach(News.previewContentList, id: \.self) { news in
          NewsSmallCard(news)
        }
      }
      .padding()
    }
    .background(Color.gray)
  }
}
