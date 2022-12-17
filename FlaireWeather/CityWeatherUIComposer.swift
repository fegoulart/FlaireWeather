//
//  CityWeatherUIComposer.swift
//  FlaireWeather
//
//  Copyright © 2022 Leapi. All rights reserved.
//

public final class CityWeatherUIComposer {
    private init() {}

    public static func cityWeatherComposedWith(weatherLoader: WeatherLoader) -> CityWeatherViewController {
        let cityWeatherViewController = CityWeatherViewController()
        let presentationAdapter = CityWeatherPresentationAdapter(cityWeatherPresenter: CityWeatherPresenter(weatherView: WeakRefVirtualProxy(cityWeatherViewController), weatherErrorView: WeakRefVirtualProxy(cityWeatherViewController), weatherLoadingView: WeakRefVirtualProxy(cityWeatherViewController.refreshControl)), weatherLoader: weatherLoader)
        cityWeatherViewController.refreshControl.delegate = presentationAdapter
        return cityWeatherViewController
    }
}



