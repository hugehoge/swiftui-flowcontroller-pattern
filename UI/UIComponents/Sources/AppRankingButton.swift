import SwiftUI

import Entities

// MARK: - _AppRankingButtonStyle

private struct _AppRankingButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
      .animation(.easeInOut, value: configuration.isPressed ? 0.95 : 1.0)
  }
}

// MARK: - AppRankingButton

public struct AppRankingButton: View {
  private let _app: AppInformation
  private let _rank: Int
  private let _action: (() -> Void)?

  public var body: some View {
    Button {
      _action?()
    } label: {
      _buttonLabel
    }
    .buttonStyle(_AppRankingButtonStyle())
  }

  private var _buttonLabel: some View {
    HStack {
      AppIcon(url: _app.iconURL)

      HStack(alignment: .firstTextBaseline) {
        Text("\(_rank)")
          .font(.headline)
          .foregroundColor(.primary)

        VStack(alignment: .leading) {
          Text(_app.name)
            .font(.headline)
            .foregroundColor(.primary)
            .lineLimit(2)
          Text(_app.seller)
            .font(.body)
            .foregroundColor(.secondary)
            .lineLimit(1)
        }
      }

      Spacer(minLength: 0)
    }
    .contentShape(Rectangle()) // For tap area
  }

  public init(
    _ app: AppInformation,
    rank: Int,
    action: (() -> Void)? = nil
  ) {
    self._app = app
    self._rank = rank
    self._action = action
  }
}

// MARK: - AppRankingButton_Previews

struct AppRankingButton_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      ForEach(0..<AppInformation.previewContentList.count) { index in
        AppRankingButton(
          AppInformation.previewContentList[index],
          rank: index + 1
        )
          .previewLayout(.fixed(width: 300, height: 100))
      }
    }
  }
}
