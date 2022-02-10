import SwiftUI

// MARK: - BulletPointText

public struct BulletPointText: View {
  private let _text: String
  private let _bulletPointMark: String

  public var body: some View {
    HStack(alignment: .top) {
      Text(_bulletPointMark)
        .padding(.trailing, 4)

      Text(_text)
        .multilineTextAlignment(.leading)
    }
  }

  public init(_ text: String, bulletPointMark: String = "-") {
    self._bulletPointMark = bulletPointMark
    self._text = text
  }
}

// MARK: - BulletPointText_Previews

struct BulletPointText_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      BulletPointText("-Test Text-")
        .padding()
        .previewLayout(.fixed(width: 400, height: 50))
        .previewDisplayName("Default")

      BulletPointText("*Test Text*", bulletPointMark: "*")
        .padding()
        .previewLayout(.fixed(width: 400, height: 50))
        .previewDisplayName("Other bullet point mark")

      VStack(alignment: .leading) {
        BulletPointText("Test Text")
        BulletPointText("")
        BulletPointText("Long long long long test text")
        BulletPointText("A")
      }
      .padding()
      .previewLayout(.fixed(width: 400, height: 100))
      .previewDisplayName("Multi length")

      BulletPointText(
        // swiftlint:disable line_length
        """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
        """
        // swiftlint:enable line_length
      )
        .padding()
        .previewLayout(.fixed(width: 400, height: 100))
        .previewDisplayName("Line break")
    }
  }
}
