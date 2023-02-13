//
//  CityWeatherUIComposer.swift
//  FlaireWeather
//
//  Copyright © 2022 Leapi. All rights reserved.
//

import Foundation

public final class CityWeatherUIComposer {
    private init() {}

    public static func cityWeatherComposedWith(weatherLoader: WeatherLoader) -> CityWeatherViewController {
        let cityWeatherViewController = CityWeatherViewController()
        let presentationAdapter = CityWeatherPresentationAdapter(cityWeatherPresenter: CityWeatherPresenter(weatherView: WeakRefVirtualProxy(cityWeatherViewController), weatherErrorView: WeakRefVirtualProxy(cityWeatherViewController), weatherLoadingView: WeakRefVirtualProxy(cityWeatherViewController.refreshControl)), weatherLoader: weatherLoader)
        cityWeatherViewController.refreshControl.delegate = presentationAdapter
        return cityWeatherViewController
    }

    public static func citiesTableComposedWith(
        weatherLoader: WorldWeatherLoader,
        delegate: SceneDelegate
    ) -> CitiesTableViewController {

        let citiesTableViewController = CitiesTableViewController(
            fetchWeather: { completion in
                DispatchQueue.global().async {
                    weatherLoader.fetchWeather { result in
                        DispatchQueue.main.async {
                            completion(result)
                        }
                    }
                }
            },
            fetchMoreWeather: { completion in
                DispatchQueue.global().async {
                    weatherLoader.fetchMoreWeather { result in
                        DispatchQueue.main.async {
                            completion(result)
                        }
                    }
                }
            },
            delegate: WeakRefVirtualProxy(delegate)
        )
        return citiesTableViewController
    }
}
