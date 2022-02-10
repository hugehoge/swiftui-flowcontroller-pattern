import Foundation

public struct AppInformation: Hashable {
  public let name: String
  public let seller: String
  public let iconURL: URL
  public let storeURL: URL

  public init(name: String, seller: String, iconURL: URL, storeURL: URL) {
    self.name = name
    self.seller = seller
    self.iconURL = iconURL
    self.storeURL = storeURL
  }
}
