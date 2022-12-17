//
//  CityWeatherUIView.swift
//  FlaireWeather
//
//  Copyright © 2022 Leapi. All rights reserved.
//

import UIKit

public final class CityWeatherUIView: UIView {

    var screenWidth: CGFloat? {
        let bounds = UIScreen.main.bounds
        return bounds.size.width
    }

    var screenHeight: CGFloat? {
        let bounds = UIScreen.main.bounds
        return bounds.size.height
    }

//    lazy var refreshControl: UIRefreshControl = {
//        let control = UIRefreshControl()
//        control.translatesAutoresizingMaskIntoConstraints = false
//        control.isUserInteractionEnabled = true
//        return control
//    }()

    var refreshControl: UIRefreshControl

    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.refreshControl = refreshControl
        return view
    }()

    lazy var loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.stopAnimating()
        view.hidesWhenStopped = true
        return view
    }()

    lazy var errorViewLabel: UILabel = {
        let label = UILabel()
        label.text = "Internet connection not available becaus an alien arrived in earth and then ate all cables and antennas"
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 18)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.backgroundColor = .red
        label.textColor = .white
        return label
    }()

    lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 6
        return stackView
    }()

    lazy var cityNameUILabel: UILabel = {
        let label = UILabel()
        label.text = "Toronto"
        label.contentMode = .bottom
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 40)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    lazy var temperatureContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
    }()

    lazy var weatherStatus: UIImageView = {
        let image = UIImage(named: "lc")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    lazy var temperature: UILabel = {
        let label = UILabel()
        label.text = "16º"
        label.contentMode = .bottom
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 40)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    lazy var statusUILabel: UILabel = {
        let label = UILabel()
        label.text = "Light Cloud"
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var lowHighUILabel: UILabel = {
        let label = UILabel()
        label.text = "L: 11º H: 17º"
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    public init(refreshControl: UIRefreshControl) {
        self.refreshControl = refreshControl
        super.init(frame: .zero)
        buildView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
