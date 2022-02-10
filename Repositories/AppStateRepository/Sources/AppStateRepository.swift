import Combine
import Foundation

import InfrastructureServices
import RepositoryServices

public final class AppStateRepository: AppStateRepositoryService {
  private let _userDefaultsManager: UserDefaultsManagerService

  // swiftlint:disable:next discouraged_optional_boolean
  private let _isWalkthroughFinishedSubject = CurrentValueSubject<Bool?, Never>(nil)

  public init(userDefaultsManager: UserDefaultsManagerService) {
    self._userDefaultsManager = userDefaultsManager

    Task {
      let isWalkthroughFinished = await userDefaultsManager.fetchIsWalkthroughFinished()
      _isWalkthroughFinishedSubject.send(isWalkthroughFinished)
    }
  }

  public func isWalkthroughFinishedStream() -> AnyPublisher<Bool, Never> {
    _isWalkthroughFinishedSubject
      .compactMap { $0 }
      .removeDuplicates()
      .eraseToAnyPublisher()
  }

  public func finishWalkthrough() async {
    await _userDefaultsManager.saveIsWalkthroughFinished(true)
    _isWalkthroughFinishedSubject.send(true)
  }
}
