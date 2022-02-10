import XCTest

import CombineExpectations
import Mockingbird

@testable import AppStateRepository
@testable import InfrastructureServices

final class AppStateRepositoryTests: XCTestCase {
  override func setUpWithError() throws {
    try super.setUpWithError()
  }

  override func tearDownWithError() throws {
    try super.tearDownWithError()
  }

  func test_isWalkthroughFinishedStream_PersistedAsFalse_InitialOutputIsFalse() async throws {
    // Arrange
    let mock = mock(UserDefaultsManagerService.self)
    given(await mock.fetchIsWalkthroughFinished()).willReturn(false)

    // Act
    let repository = AppStateRepository(userDefaultsManager: mock)
    let recorder = repository.isWalkthroughFinishedStream().record()

    let first = try wait(for: recorder.next(), timeout: 0.1)

    // Assert
    XCTAssertFalse(first)
  }

  func test_isWalkthroughFinishedStream_PersistedAsTrue_InitialOutputIsTrue() async throws {
    // Arrange
    let mock = mock(UserDefaultsManagerService.self)
    given(await mock.fetchIsWalkthroughFinished()).willReturn(true)

    // Act
    let repository = AppStateRepository(userDefaultsManager: mock)
    let recorder = repository.isWalkthroughFinishedStream().record()

    let first = try wait(for: recorder.next(), timeout: 0.1)

    // Assert
    XCTAssertTrue(first)
  }

  func test_finishWalkthrough_PersistedAsFalse_PersistTrueAndOutputTrue() async throws {
    // Arrange
    let mock = mock(UserDefaultsManagerService.self)
    given(await mock.fetchIsWalkthroughFinished()).willReturn(false)

    // Act
    let repository = AppStateRepository(userDefaultsManager: mock)
    let recorder = repository.isWalkthroughFinishedStream().record()

    await repository.finishWalkthrough()

    let output = try wait(for: recorder.availableElements, timeout: 0.1)

    // Assert
    XCTAssertEqual([false, true], output)
    verify(await mock.saveIsWalkthroughFinished(true)).wasCalled()
  }

  func test_finishWalkthrough_PersistedAsTrue_PersistTrueAndOutputTrueOnce() async throws {
    // Arrange
    let mock = mock(UserDefaultsManagerService.self)
    given(await mock.fetchIsWalkthroughFinished()).willReturn(true)

    // Act
    let repository = AppStateRepository(userDefaultsManager: mock)
    let recorder = repository.isWalkthroughFinishedStream().record()

    await repository.finishWalkthrough()

    let output = try wait(for: recorder.availableElements, timeout: 0.1)

    // Assert
    XCTAssertEqual([true], output)
    verify(await mock.saveIsWalkthroughFinished(true)).wasCalled()
  }
}
