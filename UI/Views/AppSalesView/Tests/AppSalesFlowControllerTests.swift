import Combine
import XCTest

import Mockingbird

@testable import AppSalesView
@testable import Entities
@testable import RepositoryServices

class AppSalesFlowControllerTests: XCTestCase {
  override func setUpWithError() throws {
    try super.setUpWithError()
  }

  override func tearDownWithError() throws {
    try super.tearDownWithError()
  }

  func test_start_FreeApp_SetSegmentAndCallFetch() throws {
    // Arrange
    let mockFeedRepository = mock(FeedRepositoryService.self)
    let mockPreferencesRepository = mock(PreferencesRepositoryService.self)

    let mockViewModel = mock(AppSalesViewModel.self)
      .initialize(feedRepository: mockFeedRepository, preferencesRepository: mockPreferencesRepository)
    given(mockViewModel.navigationSignal).willReturn(Empty(completeImmediately: false).eraseToAnyPublisher())

    // Act
    let viewController = AppSalesFlowController(rootView: AppSalesView(viewModel: mockViewModel))

    viewController.start(segment: .freeApp)

    // Assert
    verify(mockViewModel.setSegment(.freeApp)).wasCalled()
    verify(mockViewModel.fetch()).wasCalled()
  }

  func test_start_PaidApp_SetSegmentAndCallFetch() throws {
    // Arrange
    let mockFeedRepository = mock(FeedRepositoryService.self)
    let mockPreferencesRepository = mock(PreferencesRepositoryService.self)

    let mockViewModel = mock(AppSalesViewModel.self)
      .initialize(feedRepository: mockFeedRepository, preferencesRepository: mockPreferencesRepository)
    given(mockViewModel.navigationSignal).willReturn(Empty(completeImmediately: false).eraseToAnyPublisher())

    // Act
    let viewController = AppSalesFlowController(rootView: AppSalesView(viewModel: mockViewModel))

    viewController.start(segment: .paidApp)

    // Assert
    verify(mockViewModel.setSegment(.paidApp)).wasCalled()
    verify(mockViewModel.fetch()).wasCalled()
  }
}
