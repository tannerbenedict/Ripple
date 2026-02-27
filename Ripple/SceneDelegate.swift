//
//  SceneDelegate.swift
//  Ripple
//
//  Created on 2/26/26.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)

        // Show splash screen first
        let splashVC = UIViewController()
        splashVC.view.backgroundColor = .black
        let splashImageView = UIImageView(image: UIImage(named: "splash_screen"))
        splashImageView.contentMode = .scaleAspectFill
        splashImageView.translatesAutoresizingMaskIntoConstraints = false
        splashVC.view.addSubview(splashImageView)
        NSLayoutConstraint.activate([
            splashImageView.topAnchor.constraint(equalTo: splashVC.view.topAnchor),
            splashImageView.bottomAnchor.constraint(equalTo: splashVC.view.bottomAnchor),
            splashImageView.leadingAnchor.constraint(equalTo: splashVC.view.leadingAnchor),
            splashImageView.trailingAnchor.constraint(equalTo: splashVC.view.trailingAnchor)
        ])

        window.rootViewController = splashVC
        window.makeKeyAndVisible()
        self.window = window

        // Transition to main screen after a short delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let mainVC = ViewController()
            mainVC.view.alpha = 0
            window.rootViewController = mainVC
            UIView.animate(withDuration: 0.4) {
                mainVC.view.alpha = 1
            }
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}
