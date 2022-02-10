import SwiftUI

import Kingfisher

import Entities

// MARK: - _NewsLargeCardButtonStyle

private struct _NewsLargeCardButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
      .animation(.easeInOut, value: configuration.isPressed ? 0.95 : 1.0)
  }
}

// MARK: - NewsLargeCard

public struct NewsLargeCard: View {
  private let _news: News
  private let _action: (() -> Void)?

  public var body: some View {
    Button {
      _action?()
    } label: {
      _buttonLabel
    }
    .buttonStyle(_NewsLargeCardButtonStyle())
  }

  private var _buttonLabel: some View {
    VStack(spacing: 8) {
      KFImage(_news.imageURL)
        .cacheMemoryOnly()
        .placeholder {
          Color.gray
        }
        .resizable()
        .aspectRatio(1192 / 626, contentMode: .fit)

      HStack {
        Text(_news.category)
          .foregroundColor(.secondary)
          .font(.footnote)
          .fontWeight(.bold)
          .lineLimit(1)
        Spacer(minLength: 0)
      }
      .padding([.leading, .trailing], 16)

      HStack {
        Text(_news.title)
          .font(.headline)
          .lineLimit(3)
        Spacer(minLength: 0)
      }
      .padding([.leading, .trailing], 16)

      HStack {
        Spacer(minLength: 0)
        Text(_dateString)
          .foregroundColor(.secondary)
          .font(.footnote)
          .lineLimit(1)
      }
      .padding([.leading, .trailing], 16)
      .padding(.bottom, 8)
    }
    .background(Color(uiColor: .secondarySystemGroupedBackground))
    .cornerRadius(16)
  }

  private var _dateString: String {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none

    return formatter.string(from: _news.date)
  }

  public init(_ news: News, action: (() -> Void)? = nil) {
    self._news = news
    self._action = action
  }
}

// MARK: - NewsLargeCard_Previews

struct NewsLargeCard_Previews: PreviewProvider {
  static var previews: some View {
    ScrollView {
      VStack {
        NewsLargeCard(News.appStoreAward)
          .padding()

        NewsLargeCard(News.appleMusicAward)
          .padding()
      }
      .listStyle(.plain)
    }
    .background(Color.gray)
  }
}
