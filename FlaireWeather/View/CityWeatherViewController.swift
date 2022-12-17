//
//  ViewController.swift
//  FlaireWeather
//
//  Copyright © 2022 Leapi. All rights reserved.
//

import UIKit
import SwiftUI

final class CityWeatherViewController: UIViewController {

    var selectedCityId: Int
    var cityWeatherDelegate: CityWeatherDelegate?

    lazy var weatherView: CityWeatherUIView = {
        return CityWeatherUIView()
    }()

    var refreshControl: UIRefreshControl {
        return weatherView.refreshControl
    }

    init(selectedCityId: Int = 4118) {
        self.selectedCityId = selectedCityId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        view = weatherView
    }

    @objc
    func didPullToRefresh() {
        cityWeatherDelegate?.didRequestWeather(for: selectedCityId)
    }
}

struct CityWeatherViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            CityWeatherViewController()
        }
    }
}
