//
//  SceneDelegate.swift
//  FlaireWeather
//
//  Copyright © 2022 Leapi. All rights reserved.
//

import UIKit

public class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    public var window: UIWindow?
    let url = "https://cdn.faire.com/static/mobile-take-home"

    private lazy var httpClient: HTTPClient = {
        URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
    }()

    lazy var navigationController =  {
        // return UINavigationController(rootViewController: CityWeatherUIComposer.cityWeatherComposedWith(weatherLoader: RemoteWeatherLoader(baseUrl: url, client: httpClient)))
        return UINavigationController(rootViewController: CityWeatherUIComposer.citiesTableComposedWith(weatherLoader: MockedWeatherLoader(), delegate: self))
    }()

    public func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    public func sceneDidDisconnect(_ scene: UIScene) {
    }

    public func sceneDidBecomeActive(_ scene: UIScene) {
    }

    public func sceneWillResignActive(_ scene: UIScene) {
    }

    public func sceneWillEnterForeground(_ scene: UIScene) {
    }

    public func sceneDidEnterBackground(_ scene: UIScene) {
    }
}

extension SceneDelegate: CitiesTableDelegate {
    public func didSelect(woeid: Int) {
        let detailView = CityWeatherUIComposer.cityWeatherComposedWith(weatherLoader: RemoteWeatherLoader(baseUrl: url, client: httpClient))
        navigationController.pushViewController(detailView, animated: true)
    }
}
