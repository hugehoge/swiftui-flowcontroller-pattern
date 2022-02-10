import SwiftUI

// MARK: - _RadioButtonToggleStyle

private struct _RadioButtonToggleStyle: ToggleStyle {
  func makeBody(configuration: Configuration) -> some View {
    HStack {
      ZStack {
        Circle()
          .stroke(configuration.isOn ? Color.accentColor : Color.secondary, lineWidth: 2)
          .frame(width: 20, height: 20)
        if configuration.isOn {
          Circle()
            .fill(Color.accentColor)
            .frame(width: 12, height: 12)
        }
      }
      configuration.label
      Spacer(minLength: 0)
    }
    .contentShape(Rectangle()) // For tap area
    .onTapGesture {
      configuration.isOn.toggle()
    }
  }
}

// MARK: - RadioButton

public struct RadioButton: View {
  private let _title: String

  @Binding private var _isSelected: Bool

  public var body: some View {
    Toggle(
      _title,
      isOn: Binding(get: {
        _isSelected
      }, set: { newValue in
        if !_isSelected, newValue {
          _isSelected = newValue
        }
      })
    )
      .toggleStyle(_RadioButtonToggleStyle())
  }

  public init(_ title: String, isSelected: Binding<Bool>) {
    self._title = title
    self.__isSelected = isSelected
  }
}

// MARK: - RadioButton_Previews

struct RadioButton_Previews: PreviewProvider {
  struct RadioButtonBindingHolder: View {
    let title: String
    @State var isSelected: Bool

    var body: some View {
      RadioButton(title, isSelected: $isSelected)
    }
  }

  static var previews: some View {
    Group {
      RadioButtonBindingHolder(title: "Title", isSelected: true)
        .preferredColorScheme(.light)
        .previewLayout(.fixed(width: 200, height: 50))
        .previewDisplayName("Light selected")

      RadioButtonBindingHolder(title: "Title", isSelected: false)
        .preferredColorScheme(.light)
        .previewLayout(.fixed(width: 200, height: 50))
        .previewDisplayName("Light deselected")

      RadioButtonBindingHolder(title: "Title", isSelected: true)
        .preferredColorScheme(.dark)
        .previewLayout(.fixed(width: 200, height: 50))
        .previewDisplayName("Dark selected")

      RadioButtonBindingHolder(title: "Title", isSelected: false)
        .preferredColorScheme(.dark)
        .previewLayout(.fixed(width: 200, height: 50))
        .previewDisplayName("Dark deselected")

      RadioButtonBindingHolder(title: "Title", isSelected: true)
        .environment(\.sizeCategory, .extraSmall)
        .previewLayout(.fixed(width: 200, height: 50))
        .previewDisplayName("ExtraSmall font")

      RadioButtonBindingHolder(title: "Title", isSelected: true)
        .environment(\.sizeCategory, .extraExtraExtraLarge)
        .previewLayout(.fixed(width: 200, height: 50))
        .previewDisplayName("ExtraExtraExtraLarge font")

      RadioButtonBindingHolder(title: "Title", isSelected: true)
        .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
        .previewLayout(.fixed(width: 200, height: 50))
        .previewDisplayName("AccessibilityExtraExtraExtraLarge font")
    }
  }
}
