// SceneDelegate.swift by Gokhan Mutlu on 5.03.2023

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		
		self.window = UIWindow(windowScene: windowScene)
		
		let vc = ViewController()
		vc.view.backgroundColor = .white
		
		self.window?.rootViewController = vc
		self.window?.makeKeyAndVisible()
	}
}

