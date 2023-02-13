//
//  WeatherTableCell.swift
//  FlaireWeather
//
//  Created by Fernando Luiz Goulart on 11/02/23.
//

import UIKit

struct WeatherCellViewData {
    let cityName: String
    let currentTemp: String
    let imageUrl: String
}

class WeatherTableCell: UITableViewCell {

    var viewData: WeatherCellViewData?

    private lazy var cityNameLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.backgroundColor = .clear
        myLabel.textColor = .black
        myLabel.baselineAdjustment = .alignCenters
        myLabel.adjustsFontSizeToFitWidth = true
        myLabel.textAlignment = .center
        myLabel.contentMode = .bottom
        return myLabel
    }()

    private lazy var currentTempLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.backgroundColor = .clear
        myLabel.textColor = .yellow
        myLabel.adjustsFontSizeToFitWidth = true
        myLabel.textAlignment = .center
        myLabel.contentMode = .center
        return myLabel
    }()

    private lazy var containerStackView: UIStackView = {
        var myStackView = UIStackView()
        myStackView.axis = .horizontal
        myStackView.distribution = .fillEqually
        myStackView.alignment = .center
        myStackView.spacing = 10
        return myStackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemGray
        buildView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func refreshCell() {
        cityNameLabel.text = viewData?.cityName
        currentTempLabel.text = viewData?.currentTemp

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension WeatherTableCell: ViewCodeProtocol {
    func setupHierarchy() {
        // addSubview(cityNameLabel)
        contentView.addSubview(containerStackView)
        containerStackView.addArrangedSubview(cityNameLabel)
        containerStackView.addArrangedSubview(currentTempLabel)
        // containerStackView.addArrangedSubview(currentTempLabel)
    }

    func setupConstraints() {
        containerStackView.constraint { view in
            [
                view.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                view.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                view.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1.0),
                view.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1.0)
            ]
        }
        cityNameLabel.constraint { view in
            [
                view.topAnchor.constraint(equalTo: contentView.topAnchor),
                view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ]
        }

        currentTempLabel.constraint { view in
            [
                view.topAnchor.constraint(equalTo: contentView.topAnchor),
                view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ]
        }
    }

    func additionalSetup() {
        layoutSubviews()
    }
}
