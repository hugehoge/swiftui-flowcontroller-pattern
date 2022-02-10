import Foundation

import Kanna

import Entities
import InfrastructureServices

public final class FeedClient: FeedClientService {
  public init() { }

  public func fetchNews(language: FeedLanguage) async throws -> [News] {
    let url = URL.newsFeed(language: language)

    guard let (data, response) = try? await URLSession.shared.data(from: url) else {
      throw FeedClientError.connection
    }
    guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
      throw FeedClientError.httpStatus
    }
    guard let doc = try? Kanna.XML(xml: data, encoding: .utf8) else {
      throw FeedClientError.format
    }

    let namespaces = ["atom": "http://www.w3.org/2005/Atom"]

    let entries: [News] = try doc.xpath("//atom:entry", namespaces: namespaces).map { entry in
      guard let title = entry.xpath("/atom:title", namespaces: namespaces).first?.text,
            let category = entry.xpath("/atom:category/@term", namespaces: namespaces).first?.text,
            let dateString = entry.xpath("/atom:updated", namespaces: namespaces).first?.text,
            let date = Date(fromNewsFeedFormat: dateString),
            let imageURLString = entry.xpath("/atom:link[@rel='enclosure']/@href", namespaces: namespaces).first?.text,
            let imageURL = URL(string: imageURLString),
            let linkURLString = entry.xpath("/atom:link/@href", namespaces: namespaces).first?.text,
            let linkURL = URL(string: linkURLString) else {
        throw FeedClientError.format
      }

      return News(
        title: title,
        category: category,
        date: date,
        imageURL: imageURL,
        linkURL: linkURL
      )
    }

    return entries
  }

  public func fetchFreeAppRanking(language: FeedLanguage, limit: Int) async throws -> [AppInformation] {
    let url = URL.freeAppRankingFeed(language: language, limit: limit)

    guard let (data, response) = try? await URLSession.shared.data(from: url) else {
      throw FeedClientError.connection
    }
    guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
      throw FeedClientError.httpStatus
    }
    guard let doc = try? Kanna.XML(xml: data, encoding: .utf8) else {
      throw FeedClientError.format
    }

    let namespaces = [
      "atom": "http://www.w3.org/2005/Atom",
      "im": "http://itunes.apple.com/rss",
    ]

    let entries: [AppInformation] = try doc.xpath("//atom:entry", namespaces: namespaces).map { entry in
      guard let name = entry.xpath("/im:name", namespaces: namespaces).first?.text,
            let seller = entry.xpath("/im:artist", namespaces: namespaces).first?.text,
            let iconURLString = entry.xpath("/im:image[@height='100']", namespaces: namespaces).first?.text,
            let iconURL = URL(string: iconURLString),
            let storeURLString = entry.xpath("/atom:link[@rel='alternate']/@href", namespaces: namespaces).first?.text,
            let storeURL = URL(string: storeURLString) else {
        throw FeedClientError.format
      }

      return AppInformation(
        name: name,
        seller: seller,
        iconURL: iconURL,
        storeURL: storeURL
      )
    }

    return entries
  }

  public func fetchPaidAppRanking(language: FeedLanguage, limit: Int) async throws -> [AppInformation] {
    let url = URL.paidAppRankingFeed(language: language, limit: limit)

    guard let (data, response) = try? await URLSession.shared.data(from: url) else {
      throw FeedClientError.connection
    }
    guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
      throw FeedClientError.httpStatus
    }
    guard let doc = try? Kanna.XML(xml: data, encoding: .utf8) else {
      throw FeedClientError.format
    }

    let namespaces = [
      "atom": "http://www.w3.org/2005/Atom",
      "im": "http://itunes.apple.com/rss",
    ]

    let entries: [AppInformation] = try doc.xpath("//atom:entry", namespaces: namespaces).map { entry in
      guard let name = entry.xpath("/im:name", namespaces: namespaces).first?.text,
            let seller = entry.xpath("/im:artist", namespaces: namespaces).first?.text,
            let iconURLString = entry.xpath("/im:image[@height='100']", namespaces: namespaces).first?.text,
            let iconURL = URL(string: iconURLString),
            let storeURLString = entry.xpath("/atom:link[@rel='alternate']/@href", namespaces: namespaces).first?.text,
            let storeURL = URL(string: storeURLString) else {
        throw FeedClientError.format
      }

      return AppInformation(
        name: name,
        seller: seller,
        iconURL: iconURL,
        storeURL: storeURL
      )
    }

    return entries
  }
}
