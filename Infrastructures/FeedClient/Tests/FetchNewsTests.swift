import XCTest

import OHHTTPStubs
import OHHTTPStubsSwift

@testable import Entities
@testable import FeedClient

final class FetchNewsTests: XCTestCase {
  override func setUpWithError() throws {
    try super.setUpWithError()
  }

  override func tearDownWithError() throws {
    HTTPStubs.removeAllStubs()

    try super.tearDownWithError()
  }

  func test_English20Entries_ParseSucceeded() async throws {
    // Arrange
    stub(condition: isAbsoluteURLString(URL.newsFeed(language: .english).absoluteString)) { _ in
      HTTPStubsResponse(
        // swiftlint:disable:next force_unwrapping
        fileAtPath: OHPathForFile("stub_news_feed_20_en.xml", type(of: self))!,
        statusCode: 200,
        headers: ["Content-Type": "application/rss+xml;charset=utf-8"]
      )
    }

    // Act
    let client = FeedClient()
    let news = try await client.fetchNews(language: .english)

    // Assert
    XCTAssertEqual(20, news.count)
  }

  func test_Japanese20Entries_ParseSucceeded() async throws {
    // Arrange
    stub(condition: isAbsoluteURLString(URL.newsFeed(language: .japanese).absoluteString)) { _ in
      HTTPStubsResponse(
        // swiftlint:disable:next force_unwrapping
        fileAtPath: OHPathForFile("stub_news_feed_20_jp.xml", type(of: self))!,
        statusCode: 200,
        headers: ["Content-Type": "application/rss+xml;charset=utf-8"]
      )
    }

    // Act
    let client = FeedClient()
    let news = try await client.fetchNews(language: .japanese)

    // Assert
    XCTAssertEqual(20, news.count)
  }

  func test_English1Entry_ExpectedResult() async throws {
    // Arrange
    stub(condition: isAbsoluteURLString(URL.newsFeed(language: .english).absoluteString)) { _ in
      HTTPStubsResponse(
        // swiftlint:disable:next force_unwrapping
        fileAtPath: OHPathForFile("stub_news_feed_1_en.xml", type(of: self))!,
        statusCode: 200,
        headers: ["Content-Type": "application/rss+xml;charset=utf-8"]
      )
    }

    // Act
    let client = FeedClient()
    let news = try await client.fetchNews(language: .english)

    // Assert
    XCTAssertEqual(1, news.count)
    XCTAssertEqual("Apple services enrich peoples’ lives throughout the year", news[0].title)
    XCTAssertEqual("UPDATE", news[0].category)
    XCTAssertEqual(Date(fromNewsFeedFormat: "2022-01-10T17:56:00.624Z"), news[0].date)
    XCTAssertEqual(
      "https://www.apple.com/newsroom/images/product/apps/standard/2022/Apple_Apps-and-Services-Update_hero.jpg.og.jpg",
      news[0].imageURL.absoluteString
    )
    XCTAssertEqual(
      "https://www.apple.com/newsroom/2022/01/apple-services-enrich-peoples-lives-throughout-the-year/",
      news[0].linkURL.absoluteString
    )
  }

  func test_Japanese1Entry_ExpectedResult() async throws {
    // Arrange
    stub(condition: isAbsoluteURLString(URL.newsFeed(language: .japanese).absoluteString)) { _ in
      HTTPStubsResponse(
        // swiftlint:disable:next force_unwrapping
        fileAtPath: OHPathForFile("stub_news_feed_1_jp.xml", type(of: self))!,
        statusCode: 200,
        headers: ["Content-Type": "application/rss+xml;charset=utf-8"]
      )
    }

    // Act
    let client = FeedClient()
    let news = try await client.fetchNews(language: .japanese)

    // Assert
    XCTAssertEqual(1, news.count)
    XCTAssertEqual("Appleのサービス、年間を通して人々の暮らしを豊かに", news[0].title)
    XCTAssertEqual("新着情報", news[0].category)
    XCTAssertEqual(Date(fromNewsFeedFormat: "2022-01-11T06:25:19.214Z"), news[0].date)
    XCTAssertEqual(
      "https://www.apple.com/newsroom/images/product/apps/standard/2022/Apple_Apps-and-Services-Update_hero.jpg.og.jpg",
      news[0].imageURL.absoluteString
    )
    XCTAssertEqual(
      "https://www.apple.com/jp/newsroom/2022/01/apple-services-enrich-peoples-lives-throughout-the-year/",
      news[0].linkURL.absoluteString
    )
  }

  func test_DownNetwork_ThrowConnectionError() async throws {
    // Arrange
    stub(condition: isAbsoluteURLString(URL.newsFeed(language: .english).absoluteString)) { _ in
      HTTPStubsResponse(error: NSError(
        domain: NSURLErrorDomain,
        code: URLError.notConnectedToInternet.rawValue
      ))
    }
    stub(condition: isAbsoluteURLString(URL.newsFeed(language: .japanese).absoluteString)) { _ in
      HTTPStubsResponse(error: NSError(
        domain: NSURLErrorDomain,
        code: URLError.notConnectedToInternet.rawValue
      ))
    }

    // Act
    let client = FeedClient()
    // `XCTAssertThrowsError(try await asyncFunction())` is not supported yet.
    do {
      _ = try await client.fetchNews(language: .english)
      XCTFail("Not throw FeedClientError.connection error")
    } catch {
      // Assert
      XCTAssertEqual(FeedClientError.connection, error as? FeedClientError)
    }
    do {
      _ = try await client.fetchNews(language: .japanese)
      XCTFail("Not throw FeedClientError.connection error")
    } catch {
      // Assert
      XCTAssertEqual(FeedClientError.connection, error as? FeedClientError)
    }
  }

  func test_HTTPStatus500_ThrowHTTPStatusError() async throws {
    // Arrange
    stub(condition: isAbsoluteURLString(URL.newsFeed(language: .english).absoluteString)) { _ in
      HTTPStubsResponse(
        // swiftlint:disable:next force_unwrapping
        fileAtPath: OHPathForFile("stub_news_feed_1_en.xml", type(of: self))!,
        statusCode: 500,
        headers: ["Content-Type": "application/rss+xml;charset=utf-8"]
      )
    }
    stub(condition: isAbsoluteURLString(URL.newsFeed(language: .japanese).absoluteString)) { _ in
      HTTPStubsResponse(
        // swiftlint:disable:next force_unwrapping
        fileAtPath: OHPathForFile("stub_news_feed_1_jp.xml", type(of: self))!,
        statusCode: 500,
        headers: ["Content-Type": "application/rss+xml;charset=utf-8"]
      )
    }

    // Act
    let client = FeedClient()
    // `XCTAssertThrowsError(try await asyncFunction())` is not supported yet.
    do {
      _ = try await client.fetchNews(language: .english)
      XCTFail("Not throw FeedClientError.httpStatus error")
    } catch {
      // Assert
      XCTAssertEqual(FeedClientError.httpStatus, error as? FeedClientError)
    }
    do {
      _ = try await client.fetchNews(language: .japanese)
      XCTFail("Not throw FeedClientError.httpStatus error")
    } catch {
      // Assert
      XCTAssertEqual(FeedClientError.httpStatus, error as? FeedClientError)
    }
  }

  func test_InvalidResponseFormat_ThrowFormatError() async throws {
    // Arrange
    stub(condition: isAbsoluteURLString(URL.newsFeed(language: .english).absoluteString)) { _ in
      HTTPStubsResponse(
        // swiftlint:disable:next force_unwrapping
        data: "".data(using: .utf8)!,
        statusCode: 200,
        headers: ["Content-Type": "application/rss+xml;charset=utf-8"]
      )
    }
    stub(condition: isAbsoluteURLString(URL.newsFeed(language: .japanese).absoluteString)) { _ in
      HTTPStubsResponse(
        // swiftlint:disable:next force_unwrapping
        data: "".data(using: .utf8)!,
        statusCode: 200,
        headers: ["Content-Type": "application/rss+xml;charset=utf-8"]
      )
    }

    // Act
    let client = FeedClient()
    // `XCTAssertThrowsError(try await asyncFunction())` is not supported yet.
    do {
      _ = try await client.fetchNews(language: .english)
      XCTFail("Not throw FeedClientError.format error")
    } catch {
      // Assert
      XCTAssertEqual(FeedClientError.format, error as? FeedClientError)
    }
    do {
      _ = try await client.fetchNews(language: .japanese)
      XCTFail("Not throw FeedClientError.format error")
    } catch {
      // Assert
      XCTAssertEqual(FeedClientError.format, error as? FeedClientError)
    }
  }
}
