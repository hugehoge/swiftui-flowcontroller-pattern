import SwiftUI

// MARK: - RadioButtonGroup

public struct RadioButtonGroup: View {
  private let _titles: [String]

  @Binding private var _selectedIndex: Int?

  public var body: some View {
    VStack(alignment: .leading, spacing: 24) {
      ForEach(0..<_titles.count) { index in
        RadioButton(
          _titles[index],
          isSelected: Binding(get: {
            index == _selectedIndex
          }, set: { newValue in
            _selectedIndex = newValue ? index : nil
          })
        )
      }
    }
    .padding(4)
  }

  public init(_ titles: [String], selectedIndex: Binding<Int?>) {
    self._titles = titles
    self.__selectedIndex = selectedIndex
  }
}

// MARK: - RadioButtonGroup_Previews

struct RadioButtonGroup_Previews: PreviewProvider {
  struct RadioButtonGroupBindingHolder: View {
    let titles: [String]

    @State var selectedIndex: Int?

    var body: some View {
      RadioButtonGroup(titles, selectedIndex: $selectedIndex)
    }
  }

  static var previews: some View {
    Group {
      RadioButtonGroupBindingHolder(
        titles: [
          "Item 1",
          "Item 22",
          "Item 333",
          "Item 4444",
          "Item 55555",
          "Item 1",
        ],
        selectedIndex: nil
      )
        .previewLayout(.sizeThatFits)
    }
  }
}
