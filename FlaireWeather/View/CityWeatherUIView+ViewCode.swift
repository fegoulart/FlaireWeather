//
//  CityWeatherUIView+ViewCode.swift
//  FlaireWeather
//
//  Copyright © 2022 Leapi. All rights reserved.
//

import UIKit

extension CityWeatherUIView: ViewCodeProtocol {
    func setupHierarchy() {
        addSubview(scrollView)
        addSubview(errorViewLabel)
        scrollView.addSubview(cityNameUILabel)
        scrollView.addSubview(containerStackView)
        containerStackView.addArrangedSubview(temperatureContainer)
        temperatureContainer.addArrangedSubview(weatherStatus)
        temperatureContainer.addArrangedSubview(temperature)
        containerStackView.addArrangedSubview(statusUILabel)
        containerStackView.addArrangedSubview(lowHighUILabel)
    }

    func setupConstraints() {

        scrollView.constraint { view in
            [
                view.leadingAnchor.constraint(equalTo: leadingAnchor),
                view.trailingAnchor.constraint(equalTo: trailingAnchor),
                // view.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
                view.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                view.heightAnchor.constraint(greaterThanOrEqualToConstant: screenHeight ?? 1000)
            ]
        }

        cityNameUILabel.constraint { view in
            [
                view.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
                view.trailingAnchor.constraint(equalTo: trailingAnchor),
                view.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
                view.heightAnchor.constraint(equalToConstant: screenWidth != nil ? screenWidth!/12 : 14)
            ]
        }

        errorViewLabel.constraint { view in
            [
                view.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
                view.leftAnchor.constraint(equalTo: leftAnchor),
                view.rightAnchor.constraint(equalTo: rightAnchor),
                view.heightAnchor.constraint(equalToConstant: screenHeight != nil ? screenHeight! / 12 : 100)
            ]
        }

        containerStackView.constraint { view in
            [
                view.leadingAnchor.constraint(equalTo: leadingAnchor),
                view.trailingAnchor.constraint(equalTo: trailingAnchor),
                view.topAnchor.constraint(equalTo: cityNameUILabel.bottomAnchor, constant: 10)
            ]
        }

        weatherStatus.constraint { view in
            [
                view.widthAnchor.constraint(equalToConstant: screenWidth != nil ? screenWidth!/8 : 20),
                view.heightAnchor.constraint(equalToConstant: screenWidth != nil ? screenWidth!/8 : 20),
            ]
        }

        temperature.constraint { view in
            [
                view.heightAnchor.constraint(equalToConstant: screenWidth != nil ? screenWidth!/8 + 20 : 30),
            ]
        }

        statusUILabel.constraint { view in
            [
                view.leadingAnchor.constraint(lessThanOrEqualTo: weatherStatus.centerXAnchor),
                view.trailingAnchor.constraint(greaterThanOrEqualTo: temperature.centerXAnchor)
            ]
        }

        lowHighUILabel.constraint { view in
            [
                view.leadingAnchor.constraint(lessThanOrEqualTo: weatherStatus.leadingAnchor),
                view.trailingAnchor.constraint(greaterThanOrEqualTo: temperature.trailingAnchor)
            ]
        }
    }

    func additionalSetup() {
        self.backgroundColor = .systemBackground
    }
}
