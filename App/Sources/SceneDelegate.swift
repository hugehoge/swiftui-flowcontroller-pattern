import UIKit

import Resolver

import UIServices

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
    if let scene = scene as? UIWindowScene {
      let rootViewController = Resolver.resolve(RootFlowControllerService.self)

      let window = UIWindow(windowScene: scene)
      window.rootViewController = rootViewController
      window.makeKeyAndVisible()

      rootViewController.start()

      self.window = window
    }
  }
}
