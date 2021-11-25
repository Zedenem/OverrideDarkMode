//
/*! @copyright 2021 ___ORGANIZATIONNAME___ */

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  private(set) static var shared: SceneDelegate?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    Self.shared = self
    guard let windowScene = (scene as? UIWindowScene) else { return }

    window = UIWindow(frame: UIScreen.main.bounds)
    window?.windowScene = windowScene

    let vc = ViewController()
    window?.rootViewController = vc
    window?.makeKeyAndVisible()
  }
}

