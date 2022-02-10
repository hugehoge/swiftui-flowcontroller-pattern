import XCTest

import CombineExpectations
import Mockingbird

@testable import AppSalesView
@testable import Entities
@testable import RepositoryServices

final class AppSalesViewModelTests: XCTestCase {
  override func setUpWithError() throws {
    try super.setUpWithError()
  }

  override func tearDownWithError() throws {
    try super.tearDownWithError()
  }

  func test_fetch_FeedLanguageEnglish_RequestEnglish() async throws {
    // Arrange
    let mockFeedRepository = mock(FeedRepositoryService.self)
    given(await mockFeedRepository.fetchFreeAppAllRanking(language: .english)).willReturn([])
    given(await mockFeedRepository.fetchPaidAppAllRanking(language: .english)).willReturn([])

    let mockPreferencesRepository = mock(PreferencesRepositoryService.self)
    given(await mockPreferencesRepository.fetchFeedLanguage()).willReturn(.english)

    // Act
    let viewModel = AppSalesViewModel(
      feedRepository: mockFeedRepository,
      preferencesRepository: mockPreferencesRepository
    )
    let recorder = viewModel.$isInLoading.record()

    viewModel.fetch()
    let isInLoadingOutput = try wait(for: recorder.next(3), timeout: 0.1)

    // Assert
    XCTAssertEqual([false, true, false], isInLoadingOutput)
    verify(await mockFeedRepository.fetchFreeAppAllRanking(language: .english)).wasCalled()
    verify(await mockFeedRepository.fetchPaidAppAllRanking(language: .english)).wasCalled()
  }

  func test_fetch_FeedLanguageJapanese_RequestJapanese() async throws {
    // Arrange
    let mockFeedRepository = mock(FeedRepositoryService.self)
    given(await mockFeedRepository.fetchFreeAppAllRanking(language: .japanese)).willReturn([])
    given(await mockFeedRepository.fetchPaidAppAllRanking(language: .japanese)).willReturn([])

    let mockPreferencesRepository = mock(PreferencesRepositoryService.self)
    given(await mockPreferencesRepository.fetchFeedLanguage()).willReturn(.japanese)

    // Act
    let viewModel = AppSalesViewModel(
      feedRepository: mockFeedRepository,
      preferencesRepository: mockPreferencesRepository
    )
    let recorder = viewModel.$isInLoading.record()

    viewModel.fetch()
    let isInLoadingOutput = try wait(for: recorder.next(3), timeout: 0.1)

    // Assert
    XCTAssertEqual([false, true, false], isInLoadingOutput)
    verify(await mockFeedRepository.fetchFreeAppAllRanking(language: .japanese)).wasCalled()
    verify(await mockFeedRepository.fetchPaidAppAllRanking(language: .japanese)).wasCalled()
  }

  func test_fetch_FeedClientSucceeded_ExpectedResult() async throws {
    // Arrange
    let freeAppRanking = [
      AppInformation(
        name: "FreeApp1",
        seller: "FreeAppSeller1",
        iconURL: URL(string: "https://www.example.com/free_app_1_icon")!, // swiftlint:disable:this force_unwrapping
        storeURL: URL(string: "https://www.example.com/free_app_1_store")! // swiftlint:disable:this force_unwrapping
      ),
      AppInformation(
        name: "FreeApp2",
        seller: "FreeAppSeller2",
        iconURL: URL(string: "https://www.example.com/free_app_2_icon")!, // swiftlint:disable:this force_unwrapping
        storeURL: URL(string: "https://www.example.com/free_app_2_store")! // swiftlint:disable:this force_unwrapping
      ),
    ]
    let paidAppRanking = [
      AppInformation(
        name: "PaidApp1",
        seller: "PaidAppSeller1",
        iconURL: URL(string: "https://www.example.com/paid_app_1_icon")!, // swiftlint:disable:this force_unwrapping
        storeURL: URL(string: "https://www.example.com/paid_app_1_store")! // swiftlint:disable:this force_unwrapping
      ),
    ]

    let mockFeedRepository = mock(FeedRepositoryService.self)
    given(await mockFeedRepository.fetchFreeAppAllRanking(language: .english)).willReturn(freeAppRanking)
    given(await mockFeedRepository.fetchPaidAppAllRanking(language: .english)).willReturn(paidAppRanking)

    let mockPreferencesRepository = mock(PreferencesRepositoryService.self)
    given(await mockPreferencesRepository.fetchFeedLanguage()).willReturn(.english)

    // Act
    let viewModel = AppSalesViewModel(
      feedRepository: mockFeedRepository,
      preferencesRepository: mockPreferencesRepository
    )
    let recorder = viewModel.$isInLoading.record()

    viewModel.fetch()
    let isInLoadingOutput = try wait(for: recorder.next(3), timeout: 0.1)

    // Assert
    XCTAssertEqual([false, true, false], isInLoadingOutput)
    XCTAssertFalse(viewModel.hasError)
    XCTAssertEqual(freeAppRanking, viewModel.freeApps)
    XCTAssertEqual(paidAppRanking, viewModel.paidApps)
  }

  func test_fetch_FeedClientNotFinished_IsInLoading() async throws {
    // Arrange
    let mockFeedRepository = mock(FeedRepositoryService.self)
    given(await mockFeedRepository.fetchFreeAppAllRanking(language: .english)).will { _ in
      try await Task.sleep(nanoseconds: 10_000_000_000)
      return []
    }
    given(await mockFeedRepository.fetchPaidAppAllRanking(language: .english)).will { _ in
      try await Task.sleep(nanoseconds: 10_000_000_000)
      return []
    }

    let mockPreferencesRepository = mock(PreferencesRepositoryService.self)
    given(await mockPreferencesRepository.fetchFeedLanguage()).willReturn(.english)

    // Act
    let viewModel = AppSalesViewModel(
      feedRepository: mockFeedRepository,
      preferencesRepository: mockPreferencesRepository
    )
    let recorder = viewModel.$isInLoading.record()

    viewModel.fetch()
    let isInLoadingOutput = try wait(for: recorder.availableElements, timeout: 0.1)

    // Assert
    XCTAssertEqual([false, true], isInLoadingOutput)
  }

  func test_fetch_FeedClientPartialError_HasError() async throws {
    // Arrange
    let paidAppRanking = [
      AppInformation(
        name: "PaidApp1",
        seller: "PaidAppSeller1",
        iconURL: URL(string: "https://www.example.com/paid_app_1_icon")!, // swiftlint:disable:this force_unwrapping
        storeURL: URL(string: "https://www.example.com/paid_app_1_store")! // swiftlint:disable:this force_unwrapping
      ),
    ]

    let mockFeedRepository = mock(FeedRepositoryService.self)
    given(await mockFeedRepository.fetchFreeAppAllRanking(language: .english)).will { _ in
      try await Task.sleep(nanoseconds: 10_000_000)
      throw FeedClientError.connection
    }
    given(await mockFeedRepository.fetchPaidAppAllRanking(language: .english)).willReturn(paidAppRanking)

    let mockPreferencesRepository = mock(PreferencesRepositoryService.self)
    given(await mockPreferencesRepository.fetchFeedLanguage()).willReturn(.english)

    // Act
    let viewModel = AppSalesViewModel(
      feedRepository: mockFeedRepository,
      preferencesRepository: mockPreferencesRepository
    )
    let recorder = viewModel.$isInLoading.record()

    viewModel.fetch()
    let isInLoadingOutput = try wait(for: recorder.availableElements, timeout: 0.1)

    // Assert
    XCTAssertEqual([false, true, false], isInLoadingOutput)
    XCTAssertTrue(viewModel.hasError)
    XCTAssertEqual([], viewModel.freeApps)
    XCTAssertEqual([], viewModel.paidApps)
  }

  func test_navigate_Open_NavigationOutputOpen() throws {
    // Arrange
    let url = URL(string: "https://www.example.com/open")! // swiftlint:disable:this force_unwrapping

    let mockFeedRepository = mock(FeedRepositoryService.self)
    let mockPreferencesRepository = mock(PreferencesRepositoryService.self)

    // Act
    let viewModel = AppSalesViewModel(
      feedRepository: mockFeedRepository,
      preferencesRepository: mockPreferencesRepository
    )
    let recorder = viewModel.navigationSignal.record()

    viewModel.navigate(.appStore(url: url))
    let output = try wait(for: recorder.availableElements, timeout: 0.1)

    // Assert
    XCTAssertEqual([.appStore(url: url)], output)
  }

  func test_navigate_Never_NavigationOutputNever() throws {
    // Arrange
    let mockFeedRepository = mock(FeedRepositoryService.self)
    let mockPreferencesRepository = mock(PreferencesRepositoryService.self)

    // Act
    let viewModel = AppSalesViewModel(
      feedRepository: mockFeedRepository,
      preferencesRepository: mockPreferencesRepository
    )
    let recorder = viewModel.navigationSignal.record()

    let output = try wait(for: recorder.availableElements, timeout: 0.1)

    // Assert
    XCTAssertEqual([], output)
  }
}
