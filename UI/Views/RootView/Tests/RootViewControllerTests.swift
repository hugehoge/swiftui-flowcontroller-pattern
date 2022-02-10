import Combine
import XCTest

import Mockingbird

@testable import RepositoryServices
@testable import RootView
@testable import UIServices

class RootViewControllerTests: XCTestCase {
  override func setUpWithError() throws {
    try super.setUpWithError()
  }

  override func tearDownWithError() throws {
    try super.tearDownWithError()
  }

  @MainActor
  func test_start_NavigationWalkthrough_StartWalkthrough() async throws {
    // Arrange
    let mockAppStateRepository = mock(AppStateRepositoryService.self)
    given(mockAppStateRepository.isWalkthroughFinishedStream())
      .willReturn(Empty(completeImmediately: false).eraseToAnyPublisher())

    let mockViewModel = mock(RootViewModel.self)
      .initialize(appStateRepository: mockAppStateRepository)
    given(mockViewModel.navigationStream)
      .willReturn(Just(.walkthrough).append(Empty(completeImmediately: false)).eraseToAnyPublisher())

    let mockWalkthroughFlowController = mock(WalkthroughFlowControllerService.self)
      .initialize(nibName: nil, bundle: nil)
    let mockMainFlowController = mock(MainFlowControllerService.self)
      .initialize(nibName: nil, bundle: nil)

    // Act
    let viewController = RootFlowController(
      rootViewModel: mockViewModel,
      walkthroughProvider: mockWalkthroughFlowController,
      mainProvider: mockMainFlowController
    )

    viewController.start()

    try await Task.sleep(nanoseconds: 100_000_000)

    // Assert
    verify(mockWalkthroughFlowController.start()).wasCalled()
    verify(mockMainFlowController.start()).wasNeverCalled()
  }

  @MainActor
  func test_start_NavigationMain_StartMain() async throws {
    // Arrange
    let mockAppStateRepository = mock(AppStateRepositoryService.self)
    given(mockAppStateRepository.isWalkthroughFinishedStream())
      .willReturn(Empty(completeImmediately: false).eraseToAnyPublisher())

    let mockViewModel = mock(RootViewModel.self)
      .initialize(appStateRepository: mockAppStateRepository)
    given(mockViewModel.navigationStream)
      .willReturn(Just(.main).append(Empty(completeImmediately: false)).eraseToAnyPublisher())

    let mockWalkthroughFlowController = mock(WalkthroughFlowControllerService.self)
      .initialize(nibName: nil, bundle: nil)
    let mockMainFlowController = mock(MainFlowControllerService.self)
      .initialize(nibName: nil, bundle: nil)

    // Act
    let viewController = RootFlowController(
      rootViewModel: mockViewModel,
      walkthroughProvider: mockWalkthroughFlowController,
      mainProvider: mockMainFlowController
    )

    viewController.start()

    try await Task.sleep(nanoseconds: 100_000_000)

    // Assert
    verify(mockWalkthroughFlowController.start()).wasNeverCalled()
    verify(mockMainFlowController.start()).wasCalled()
  }
}
