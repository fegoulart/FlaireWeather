//
//  SceneDelegate.swift
//  FlaireWeather
//
//  Copyright © 2022 Leapi. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    lazy var navigationController: UINavigationController = {
        let cityWeatherViewController = CityWeatherViewController()
        let presenter = CityWeatherPresenter(
            weatherView: cityWeatherViewController,
            weatherErrorView: cityWeatherViewController,
            weatherLoadingView: cityWeatherViewController
        )
        let weatherLoader = RemoteWeatherLoader()
        let presentationAdapter = CityWeatherPresentationAdapter(
            cityWeatherPresenter: presenter,
            weatherLoader: weatherLoader
        )
        cityWeatherViewController.cityWeatherDelegate = presentationAdapter
        return UINavigationController(rootViewController: cityWeatherViewController)
    }()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
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
