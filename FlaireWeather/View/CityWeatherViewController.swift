//
//  ViewController.swift
//  FlaireWeather
//
//  Copyright © 2022 Leapi. All rights reserved.
//

import UIKit
import SwiftUI

class CityWeatherViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view = CityWeatherUIView()
    }
}

struct CityWeatherViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            CityWeatherViewController()
        }
    }
}

