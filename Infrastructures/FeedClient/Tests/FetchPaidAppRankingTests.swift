import XCTest

import OHHTTPStubs
import OHHTTPStubsSwift

@testable import Entities
@testable import FeedClient

final class FetchPaidAppRankingTests: XCTestCase {
  override func setUpWithError() throws {
    try super.setUpWithError()
  }

  override func tearDownWithError() throws {
    HTTPStubs.removeAllStubs()

    try super.tearDownWithError()
  }

  func test_English15Entries_ParseSucceeded() async throws {
    // Arrange
    stub(condition: isAbsoluteURLString(URL.paidAppRankingFeed(language: .english, limit: 15).absoluteString)) { _ in
      HTTPStubsResponse(
        // swiftlint:disable:next force_unwrapping
        fileAtPath: OHPathForFile("stub_paid_app_ranking_feed_15_en.xml", type(of: self))!,
        statusCode: 200,
        headers: ["Content-Type": "application/rss+xml;charset=utf-8"]
      )
    }

    // Act
    let client = FeedClient()
    let ranking = try await client.fetchPaidAppRanking(language: .english, limit: 15)

    // Assert
    XCTAssertEqual(15, ranking.count)
  }

  func test_Japanese15Entries_ParseSucceeded() async throws {
    // Arrange
    stub(condition: isAbsoluteURLString(URL.paidAppRankingFeed(language: .japanese, limit: 15).absoluteString)) { _ in
      HTTPStubsResponse(
        // swiftlint:disable:next force_unwrapping
        fileAtPath: OHPathForFile("stub_paid_app_ranking_feed_15_jp.xml", type(of: self))!,
        statusCode: 200,
        headers: ["Content-Type": "application/rss+xml;charset=utf-8"]
      )
    }

    // Act
    let client = FeedClient()
    let ranking = try await client.fetchPaidAppRanking(language: .japanese, limit: 15)

    // Assert
    XCTAssertEqual(15, ranking.count)
  }

  func test_English1Entry_ExpectedResult() async throws {
    // Arrange
    stub(condition: isAbsoluteURLString(URL.paidAppRankingFeed(language: .english, limit: 1).absoluteString)) { _ in
      HTTPStubsResponse(
        // swiftlint:disable:next force_unwrapping
        fileAtPath: OHPathForFile("stub_paid_app_ranking_feed_1_en.xml", type(of: self))!,
        statusCode: 200,
        headers: ["Content-Type": "application/rss+xml;charset=utf-8"]
      )
    }

    // Act
    let client = FeedClient()
    let ranking = try await client.fetchPaidAppRanking(language: .english, limit: 1)

    // Assert
    XCTAssertEqual(1, ranking.count)
    XCTAssertEqual("Minecraft", ranking[0].name)
    XCTAssertEqual("Mojang", ranking[0].seller)
    XCTAssertEqual(
      // swiftlint:disable:next line_length
      "https://is4-ssl.mzstatic.com/image/thumb/Purple116/v4/d8/74/95/d87495c8-df3f-4e62-1982-f3fac9bd8601/AppIcon-0-0-1x_U007emarketing-0-0-0-9-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/100x100bb.png",
      ranking[0].iconURL.absoluteString
    )
    XCTAssertEqual(
      "https://apps.apple.com/us/app/minecraft/id479516143?uo=2",
      ranking[0].storeURL.absoluteString
    )
  }

  func test_Japanese1Entry_ExpectedResult() async throws {
    // Arrange
    stub(condition: isAbsoluteURLString(URL.paidAppRankingFeed(language: .japanese, limit: 1).absoluteString)) { _ in
      HTTPStubsResponse(
        // swiftlint:disable:next force_unwrapping
        fileAtPath: OHPathForFile("stub_paid_app_ranking_feed_1_jp.xml", type(of: self))!,
        statusCode: 200,
        headers: ["Content-Type": "application/rss+xml;charset=utf-8"]
      )
    }

    // Act
    let client = FeedClient()
    let ranking = try await client.fetchPaidAppRanking(language: .japanese, limit: 1)

    // Assert
    XCTAssertEqual(1, ranking.count)
    XCTAssertEqual("Minecraft", ranking[0].name)
    XCTAssertEqual("Mojang", ranking[0].seller)
    XCTAssertEqual(
      // swiftlint:disable:next line_length
      "https://is4-ssl.mzstatic.com/image/thumb/Purple116/v4/d8/74/95/d87495c8-df3f-4e62-1982-f3fac9bd8601/AppIcon-0-0-1x_U007emarketing-0-0-0-9-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/100x100bb.png",
      ranking[0].iconURL.absoluteString
    )
    XCTAssertEqual(
      "https://apps.apple.com/jp/app/minecraft/id479516143?uo=2",
      ranking[0].storeURL.absoluteString
    )
  }

  func test_DownNetwork_ThrowConnectionError() async throws {
    // Arrange
    stub(condition: isAbsoluteURLString(URL.paidAppRankingFeed(language: .english, limit: 1).absoluteString)) { _ in
      HTTPStubsResponse(error: NSError(
        domain: NSURLErrorDomain,
        code: URLError.notConnectedToInternet.rawValue
      ))
    }
    stub(condition: isAbsoluteURLString(URL.paidAppRankingFeed(language: .japanese, limit: 1).absoluteString)) { _ in
      HTTPStubsResponse(error: NSError(
        domain: NSURLErrorDomain,
        code: URLError.notConnectedToInternet.rawValue
      ))
    }

    // Act
    let client = FeedClient()
    // `XCTAssertThrowsError(try await asyncFunction())` is not supported yet.
    do {
      _ = try await client.fetchPaidAppRanking(language: .english, limit: 1)
      XCTFail("Not throw FeedClientError.connection error")
    } catch {
      // Assert
      XCTAssertEqual(FeedClientError.connection, error as? FeedClientError)
    }
    do {
      _ = try await client.fetchPaidAppRanking(language: .japanese, limit: 1)
      XCTFail("Not throw FeedClientError.connection error")
    } catch {
      // Assert
      XCTAssertEqual(FeedClientError.connection, error as? FeedClientError)
    }
  }

  func test_HTTPStatus500_ThrowHTTPStatusError() async throws {
    // Arrange
    stub(condition: isAbsoluteURLString(URL.paidAppRankingFeed(language: .english, limit: 1).absoluteString)) { _ in
      HTTPStubsResponse(
        // swiftlint:disable:next force_unwrapping
        fileAtPath: OHPathForFile("stub_paid_app_ranking_feed_1_en.xml", type(of: self))!,
        statusCode: 500,
        headers: ["Content-Type": "application/rss+xml;charset=utf-8"]
      )
    }
    stub(condition: isAbsoluteURLString(URL.paidAppRankingFeed(language: .japanese, limit: 1).absoluteString)) { _ in
      HTTPStubsResponse(
        // swiftlint:disable:next force_unwrapping
        fileAtPath: OHPathForFile("stub_paid_app_ranking_feed_1_jp.xml", type(of: self))!,
        statusCode: 500,
        headers: ["Content-Type": "application/rss+xml;charset=utf-8"]
      )
    }

    // Act
    let client = FeedClient()
    // `XCTAssertThrowsError(try await asyncFunction())` is not supported yet.
    do {
      _ = try await client.fetchPaidAppRanking(language: .english, limit: 1)
      XCTFail("Not throw FeedClientError.httpStatus error")
    } catch {
      // Assert
      XCTAssertEqual(FeedClientError.httpStatus, error as? FeedClientError)
    }
    do {
      _ = try await client.fetchPaidAppRanking(language: .japanese, limit: 1)
      XCTFail("Not throw FeedClientError.httpStatus error")
    } catch {
      // Assert
      XCTAssertEqual(FeedClientError.httpStatus, error as? FeedClientError)
    }
  }

  func test_InvalidResponseFormat_ThrowFormatError() async throws {
    // Arrange
    stub(condition: isAbsoluteURLString(URL.paidAppRankingFeed(language: .english, limit: 1).absoluteString)) { _ in
      HTTPStubsResponse(
        // swiftlint:disable:next force_unwrapping
        data: "".data(using: .utf8)!,
        statusCode: 200,
        headers: ["Content-Type": "application/rss+xml;charset=utf-8"]
      )
    }
    stub(condition: isAbsoluteURLString(URL.paidAppRankingFeed(language: .japanese, limit: 1).absoluteString)) { _ in
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
      _ = try await client.fetchPaidAppRanking(language: .english, limit: 1)
      XCTFail("Not throw FeedClientError.format error")
    } catch {
      // Assert
      XCTAssertEqual(FeedClientError.format, error as? FeedClientError)
    }
    do {
      _ = try await client.fetchPaidAppRanking(language: .japanese, limit: 1)
      XCTFail("Not throw FeedClientError.format error")
    } catch {
      // Assert
      XCTAssertEqual(FeedClientError.format, error as? FeedClientError)
    }
  }
}
