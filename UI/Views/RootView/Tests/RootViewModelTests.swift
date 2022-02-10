import Combine
import XCTest

import CombineExpectations
import Mockingbird

@testable import Entities
@testable import RepositoryServices
@testable import RootView

class RootViewModelTests: XCTestCase {
  override func setUpWithError() throws {
    try super.setUpWithError()
  }

  override func tearDownWithError() throws {
    try super.tearDownWithError()
  }

  func test_navigationStream_IsWalkthroughFinishedNever_OutputNever() throws {
    // Arrange
    let mockAppStateRepository = mock(AppStateRepositoryService.self)
    given(mockAppStateRepository.isWalkthroughFinishedStream())
      .willReturn(Empty(completeImmediately: false).eraseToAnyPublisher())

    // Act
    let viewModel = RootViewModel(appStateRepository: mockAppStateRepository)
    let recorder = viewModel.navigationStream.record()

    let output = try wait(for: recorder.availableElements, timeout: 0.1)

    // Assert
    XCTAssertEqual([], output)
  }

  func test_navigationStream_IsWalkthroughFinishedFalse_OutputWalkthrough() throws {
    // Arrange
    let mockAppStateRepository = mock(AppStateRepositoryService.self)
    given(mockAppStateRepository.isWalkthroughFinishedStream())
      .willReturn(Just(false).append(Empty(completeImmediately: false)).eraseToAnyPublisher())

    // Act
    let viewModel = RootViewModel(appStateRepository: mockAppStateRepository)
    let recorder = viewModel.navigationStream.record()

    let output = try wait(for: recorder.availableElements, timeout: 0.1)

    // Assert
    XCTAssertEqual([.walkthrough], output)
  }

  func test_navigationStream_IsWalkthroughFinishedTrue_OutputMain() throws {
    // Arrange
    let mockAppStateRepository = mock(AppStateRepositoryService.self)
    given(mockAppStateRepository.isWalkthroughFinishedStream())
      .willReturn(Just(true).append(Empty(completeImmediately: false)).eraseToAnyPublisher())

    // Act
    let viewModel = RootViewModel(appStateRepository: mockAppStateRepository)
    let recorder = viewModel.navigationStream.record()

    let output = try wait(for: recorder.availableElements, timeout: 0.1)

    // Assert
    XCTAssertEqual([.main], output)
  }
}
