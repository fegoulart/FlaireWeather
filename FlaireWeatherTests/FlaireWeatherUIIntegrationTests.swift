//
//  FlaireWeatherIntegrationTests.swift
//  FlaireWeatherTests
//
//  Copyright © 2022 Leapi. All rights reserved.
//

import XCTest
import FlaireWeather
import UIKit

final class FlaireWeatherIntegrationTests: XCTestCase {

    func test_loadWeatherActions_requestWeatherFromLoader() {
        let (sut, loader) = makeSUT()
        XCTAssertEqual(loader.loadCallCount, 0, "Expected no loading")

        sut.loadViewIfNeeded()
        XCTAssertEqual(loader.loadCallCount, 1)

        sut.simulateUserInitiatedReload()
        XCTAssertEqual(loader.loadCallCount, 2)
    }


    // MARK: - Helpers

    private func makeSUT(
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> (sut: CityWeatherViewController, loader: LoaderSpy) {
        let loader = LoaderSpy()
        let sut = CityWeatherUIComposer.cityWeatherComposedWith(weatherLoader: loader)
        let refreshControl = sut.refreshControl
        trackForMemoryLeaks(loader, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(refreshControl, file: file, line: line)
        return (sut, loader)
    }

    private class LoaderSpy: WeatherLoader {

        var completions: [(Result<FlaireWeather.CityWeather, FlaireWeather.WeatherLoaderError>) -> Void] = []

        var loadCallCount: Int {
            return completions.count
        }

        func fetchWeather(for cityId: Int, completion: @escaping (WeatherLoader.Result) -> Void) -> FlaireWeather.WeatherLoaderTask? {
            completions.append(completion)
            return nil
        }

        init() {

        }
    }
}

extension CityWeatherViewController {
    func simulateUserInitiatedReload() {
        self.refreshControl.simulatePullToRefresh()
    }
}

extension UIRefreshControl {
    func simulatePullToRefresh() {
        simulate(event: .valueChanged)
    }
}

extension UIControl {
    func simulate(event: UIControl.Event) {
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: event)?.forEach {
                (target as NSObject).perform(Selector($0))
            }
        }
    }
}
