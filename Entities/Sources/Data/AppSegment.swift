public enum AppSegment {
  case freeApp
  case paidApp

  public var title: String {
    switch self {
    case .freeApp:
      return "Free App"

    case .paidApp:
      return "Paid App"
    }
  }
}
