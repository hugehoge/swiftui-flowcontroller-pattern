import Foundation

public struct News: Hashable {
  public let title: String
  public let category: String
  public let date: Date
  public let imageURL: URL
  public let linkURL: URL

  public init(
    title: String,
    category: String,
    date: Date,
    imageURL: URL,
    linkURL: URL
  ) {
    self.title = title
    self.category = category
    self.date = date
    self.imageURL = imageURL
    self.linkURL = linkURL
  }
}
