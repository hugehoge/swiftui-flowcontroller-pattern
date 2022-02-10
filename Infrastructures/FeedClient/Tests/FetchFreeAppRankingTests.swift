import XCTest

import OHHTTPStubs
import OHHTTPStubsSwift

@testable import Entities
@testable import FeedClient

final class FetchFreeAppRankingTests: XCTestCase {
  override func setUpWithError() throws {
    try super.setUpWithError()
  }

  override func tearDownWithError() throws {
    HTTPStubs.removeAllStubs()

    try super.tearDownWithError()
  }

  func test_English15Entries_ParseSucceeded() async throws {
    // Arrange
    stub(condition: isAbsoluteURLString(URL.freeAppRankingFeed(language: .english, limit: 15).absoluteString)) { _ in
      HTTPStubsResponse(
        // swiftlint:disable:next force_unwrapping
        fileAtPath: OHPathForFile("stub_free_app_ranking_feed_15_en.xml", type(of: self))!,
        statusCode: 200,
        headers: ["Content-Type": "application/rss+xml;charset=utf-8"]
      )
    }

    // Act
    let client = FeedClient()
    let ranking = try await client.fetchFreeAppRanking(language: .english, limit: 15)

    // Assert
    XCTAssertEqual(15, ranking.count)
  }

  func test_Japanese15Entries_ParseSucceeded() async throws {
    // Arrange
    stub(condition: isAbsoluteURLString(URL.freeAppRankingFeed(language: .japanese, limit: 15).absoluteString)) { _ in
      HTTPStubsResponse(
        // swiftlint:disable:next force_unwrapping
        fileAtPath: OHPathForFile("stub_free_app_ranking_feed_15_jp.xml", type(of: self))!,
        statusCode: 200,
        headers: ["Content-Type": "application/rss+xml;charset=utf-8"]
      )
    }

    // Act
    let client = FeedClient()
    let ranking = try await client.fetchFreeAppRanking(language: .japanese, limit: 15)

    // Assert
    XCTAssertEqual(15, ranking.count)
  }

  func test_English1Entry_ExpectedResult() async throws {
    // Arrange
    stub(condition: isAbsoluteURLString(URL.freeAppRankingFeed(language: .english, limit: 1).absoluteString)) { _ in
      HTTPStubsResponse(
        // swiftlint:disable:next force_unwrapping
        fileAtPath: OHPathForFile("stub_free_app_ranking_feed_1_en.xml", type(of: self))!,
        statusCode: 200,
        headers: ["Content-Type": "application/rss+xml;charset=utf-8"]
      )
    }

    // Act
    let client = FeedClient()
    let ranking = try await client.fetchFreeAppRanking(language: .english, limit: 1)

    // Assert
    XCTAssertEqual(1, ranking.count)
    XCTAssertEqual("NoteIt - Drawing App", ranking[0].name)
    XCTAssertEqual("Vitor Bukovitz", ranking[0].seller)
    XCTAssertEqual(
      // swiftlint:disable:next line_length
      "https://is3-ssl.mzstatic.com/image/thumb/Purple126/v4/19/91/ea/1991ea05-f944-9b5c-993b-0fdf95cc28fc/AppIcon-1x_U007emarketing-0-7-0-85-220.png/100x100bb.png",
      ranking[0].iconURL.absoluteString
    )
    XCTAssertEqual(
      "https://apps.apple.com/us/app/noteit-drawing-app/id1570369625?uo=2",
      ranking[0].storeURL.absoluteString
    )
  }

  func test_Japanese1Entry_ExpectedResult() async throws {
    // Arrange
    stub(condition: isAbsoluteURLString(URL.freeAppRankingFeed(language: .japanese, limit: 1).absoluteString)) { _ in
      HTTPStubsResponse(
        // swiftlint:disable:next force_unwrapping
        fileAtPath: OHPathForFile("stub_free_app_ranking_feed_1_jp.xml", type(of: self))!,
        statusCode: 200,
        headers: ["Content-Type": "application/rss+xml;charset=utf-8"]
      )
    }

    // Act
    let client = FeedClient()
    let ranking = try await client.fetchFreeAppRanking(language: .japanese, limit: 1)

    // Assert
    XCTAssertEqual(1, ranking.count)
    XCTAssertEqual("運がいい日がわかるカレンダー", ranking[0].name)
    XCTAssertEqual("ZAPPALLAS, INC.", ranking[0].seller)
    XCTAssertEqual(
      // swiftlint:disable:next line_length
      "https://is1-ssl.mzstatic.com/image/thumb/Purple116/v4/6c/36/f0/6c36f0d3-c38b-3873-b6ee-5faa66543015/AppIcon-1x_U007emarketing-0-7-0-85-220.png/100x100bb.png",
      ranking[0].iconURL.absoluteString
    )
    XCTAssertEqual(
      // swiftlint:disable:next line_length
      "https://apps.apple.com/jp/app/%E9%81%8B%E3%81%8C%E3%81%84%E3%81%84%E6%97%A5%E3%81%8C%E3%82%8F%E3%81%8B%E3%82%8B%E3%82%AB%E3%83%AC%E3%83%B3%E3%83%80%E3%83%BC/id1594184354?uo=2",
      ranking[0].storeURL.absoluteString
    )
  }

  func test_DownNetwork_ThrowConnectionError() async throws {
    // Arrange
    stub(condition: isAbsoluteURLString(URL.freeAppRankingFeed(language: .english, limit: 1).absoluteString)) { _ in
      HTTPStubsResponse(error: NSError(
        domain: NSURLErrorDomain,
        code: URLError.notConnectedToInternet.rawValue
      ))
    }
    stub(condition: isAbsoluteURLString(URL.freeAppRankingFeed(language: .japanese, limit: 1).absoluteString)) { _ in
      HTTPStubsResponse(error: NSError(
        domain: NSURLErrorDomain,
        code: URLError.notConnectedToInternet.rawValue
      ))
    }

    // Act
    let client = FeedClient()
    // `XCTAssertThrowsError(try await asyncFunction())` is not supported yet.
    do {
      _ = try await client.fetchFreeAppRanking(language: .english, limit: 1)
      XCTFail("Not throw FeedClientError.connection error")
    } catch {
      // Assert
      XCTAssertEqual(FeedClientError.connection, error as? FeedClientError)
    }
    do {
      _ = try await client.fetchFreeAppRanking(language: .japanese, limit: 1)
      XCTFail("Not throw FeedClientError.connection error")
    } catch {
      // Assert
      XCTAssertEqual(FeedClientError.connection, error as? FeedClientError)
    }
  }

  func test_HTTPStatus500_ThrowHTTPStatusError() async throws {
    // Arrange
    stub(condition: isAbsoluteURLString(URL.freeAppRankingFeed(language: .english, limit: 1).absoluteString)) { _ in
      HTTPStubsResponse(
        // swiftlint:disable:next force_unwrapping
        fileAtPath: OHPathForFile("stub_free_app_ranking_feed_1_en.xml", type(of: self))!,
        statusCode: 500,
        headers: ["Content-Type": "application/rss+xml;charset=utf-8"]
      )
    }
    stub(condition: isAbsoluteURLString(URL.freeAppRankingFeed(language: .japanese, limit: 1).absoluteString)) { _ in
      HTTPStubsResponse(
        // swiftlint:disable:next force_unwrapping
        fileAtPath: OHPathForFile("stub_free_app_ranking_feed_1_jp.xml", type(of: self))!,
        statusCode: 500,
        headers: ["Content-Type": "application/rss+xml;charset=utf-8"]
      )
    }

    // Act
    let client = FeedClient()
    // `XCTAssertThrowsError(try await asyncFunction())` is not supported yet.
    do {
      _ = try await client.fetchFreeAppRanking(language: .english, limit: 1)
      XCTFail("Not throw FeedClientError.httpStatus error")
    } catch {
      // Assert
      XCTAssertEqual(FeedClientError.httpStatus, error as? FeedClientError)
    }
    do {
      _ = try await client.fetchFreeAppRanking(language: .japanese, limit: 1)
      XCTFail("Not throw FeedClientError.httpStatus error")
    } catch {
      // Assert
      XCTAssertEqual(FeedClientError.httpStatus, error as? FeedClientError)
    }
  }

  func test_InvalidResponseFormat_ThrowFormatError() async throws {
    // Arrange
    stub(condition: isAbsoluteURLString(URL.freeAppRankingFeed(language: .english, limit: 1).absoluteString)) { _ in
      HTTPStubsResponse(
        // swiftlint:disable:next force_unwrapping
        data: "".data(using: .utf8)!,
        statusCode: 200,
        headers: ["Content-Type": "application/rss+xml;charset=utf-8"]
      )
    }
    stub(condition: isAbsoluteURLString(URL.freeAppRankingFeed(language: .japanese, limit: 1).absoluteString)) { _ in
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
      _ = try await client.fetchFreeAppRanking(language: .english, limit: 1)
      XCTFail("Not throw FeedClientError.format error")
    } catch {
      // Assert
      XCTAssertEqual(FeedClientError.format, error as? FeedClientError)
    }
    do {
      _ = try await client.fetchFreeAppRanking(language: .japanese, limit: 1)
      XCTFail("Not throw FeedClientError.format error")
    } catch {
      // Assert
      XCTAssertEqual(FeedClientError.format, error as? FeedClientError)
    }
  }
}
