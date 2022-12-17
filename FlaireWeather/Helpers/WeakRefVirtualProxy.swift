//
//  WeakRefVirtualProxy.swift
//  FlaireWeather
//
//  Copyright © 2022 Leapi. All rights reserved.
//

import Foundation


/// Use WeakRefVirtualProxy when you need a weak reference but you don't want to conform your protocol to AnyObject
public final class WeakRefVirtualProxy<T: AnyObject> {
    private weak var object: T?

    public init(_ object: T) {
        self.object = object
    }
}

extension WeakRefVirtualProxy: WeatherErrorView where T: WeatherErrorView {
    public func display(_ viewModel: WeatherErrorViewModel) {
        object?.display(viewModel)
    }
}

extension WeakRefVirtualProxy: WeatherLoadingView where T: WeatherLoadingView {
    public func display(_ viewModel: WeatherLoadingViewModel) {
        object?.display(viewModel)
    }
}

extension WeakRefVirtualProxy: WeatherView where T: WeatherView {
    public func display(_ viewModel: WeatherViewModel) {
        object?.display(viewModel)
    }
}
