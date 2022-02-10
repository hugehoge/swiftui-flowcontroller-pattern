import Foundation

extension Date {
  init?(fromNewsFeedFormat string: String) {
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions.insert(.withFractionalSeconds)

    guard let date = formatter.date(from: string) else { return nil }

    self = date
  }
}
