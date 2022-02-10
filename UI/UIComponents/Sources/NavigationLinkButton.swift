import SwiftUI

// MARK: - NavigationLinkButton

/// A Button in NavigationView simulating NavigationLink
///
/// - seealso: https://ideal-reality.com/programing/swiftui-list-navlink-design/
public struct NavigationLinkButton: View {
  private let _title: String?
  private let _action: () -> Void

  public var body: some View {
    Button(action: _action) {
      HStack {
        if let title = _title {
          Text(title)
            .foregroundColor(.primary)
        }
        Spacer()
        Image(systemName: "chevron.right")
          .font(Font.system(size: 14, weight: .semibold))
          .foregroundColor(.secondary)
          .opacity(0.5)
      }
    }
  }

  public init(_ title: String?, action: @escaping () -> Void) {
    self._title = title
    self._action = action
  }
}

// MARK: - NavigationLinkButton_Previews

struct NavigationLinkButton_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      NavigationView {
        List {
          NavigationLink("Original", destination: EmptyView())
          NavigationLinkButton("NavigationLinkButton") { }
        }
        .listStyle(.plain)
      }
      .preferredColorScheme(.light)
      .previewLayout(.fixed(width: 300, height: 200))
      .previewDisplayName("Light plain")

      NavigationView {
        List {
          NavigationLink("Original", destination: EmptyView())
          NavigationLinkButton("NavigationLinkButton") { }
        }
        .listStyle(.insetGrouped)
      }
      .preferredColorScheme(.light)
      .previewLayout(.fixed(width: 300, height: 200))
      .previewDisplayName("Light inset group")

      NavigationView {
        List {
          NavigationLink("Original", destination: EmptyView())
          NavigationLinkButton("NavigationLinkButton") { }
        }
        .listStyle(.plain)
      }
      .preferredColorScheme(.dark)
      .previewLayout(.fixed(width: 300, height: 200))
      .previewDisplayName("Dark plain")

      NavigationView {
        List {
          NavigationLink("Original", destination: EmptyView())
          NavigationLinkButton("NavigationLinkButton") { }
        }
        .listStyle(.insetGrouped)
      }
      .preferredColorScheme(.dark)
      .previewLayout(.fixed(width: 300, height: 200))
      .previewDisplayName("Dark inset group")
    }
  }
}
