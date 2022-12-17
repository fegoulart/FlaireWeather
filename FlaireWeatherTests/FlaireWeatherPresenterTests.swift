//
//  FlaireWeatherTests.swift
//  FlaireWeatherTests
//
//  Copyright © 2022 Leapi. All rights reserved.
//

import XCTest
import FlaireWeather

final class FlaireWeatherPresenterTests: XCTestCase {

    func test_init_doesNotSendMessagesToView() {
        let (_, view) = makeSUT()

        XCTAssertTrue(view.messages.isEmpty, "Expected no view messages")
    }

    func test_didStartLoadingCityWeather_displaysNoErrorMessageAndStartsLoading() {
        let (sut, view) = makeSUT()

        sut.didStartLoading()

        XCTAssertEqual(view.messages, [
            .displayErrorMessage(.none),
            .displayIsLoading(true)
        ])
    }

    func test_didFinishLoadingCityWeather_displaysWeatherAndStopsLoading() {
        let (sut, view) = makeSUT()
        let weather = WeatherViewModel(city: "Rio de Janeiro", temperature: "40º", minMax: "L: 25º H: 40º", state: "Cloudy", stateImgUrl: URL(string: "http://any.com")!)
        let cityWeather = CityWeather(cityName: "Rio de Janeiro", temperature: 40, minimum: 25, maximum: 40, state: "Cloudy", stateImgUrl: "http://any.com")
        sut.didFinishLoading(with: cityWeather)

        XCTAssertEqual(view.messages, [
            .displayWeather(weather),
            .displayIsLoading(false)
        ])
    }

    func test_didFinishLoadingWeatherWithError_displaysErrorMessageAndStopsLoading() {
        let (sut, view) = makeSUT()

        sut.didFinishLoading(with: WeatherLoaderError.networkError)

        XCTAssertEqual(view.messages, [
            .displayErrorMessage("Could not fetch weather. Please try again later."),
            .displayIsLoading(false)
        ])
    }

    // MARK: - Helper Methods

    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: CityWeatherPresenter, view: ViewSpy) {
        let view = ViewSpy()
        let sut = CityWeatherPresenter(weatherView: view, weatherErrorView: view, weatherLoadingView: view)
        trackForMemoryLeaks(view, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, view)
    }

    private func anyNSError() -> NSError {
        return NSError(domain: "any error", code: 0)
    }
}

final class ViewSpy: WeatherView, WeatherErrorView, WeatherLoadingView {

    enum Message: Hashable {
        case displayErrorMessage(String?)
        case displayIsLoading(Bool)
        case displayWeather(WeatherViewModel)
    }

    private(set) var messages = Set<Message>()

    func display(_ viewModel: FlaireWeather.WeatherViewModel) {
        messages.insert(.displayWeather(viewModel))
    }

    func display(_ viewModel: FlaireWeather.WeatherErrorViewModel) {
        messages.insert(.displayErrorMessage(viewModel.message))
    }

    func display(_ viewModel: FlaireWeather.WeatherLoadingViewModel) {
        messages.insert(.displayIsLoading(viewModel.isLoading))
    }
}
