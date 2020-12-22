//
//  DetailsViewController.swift
//  Assignment4
//
//  Created by 杉原大貴 on 2020/12/15.
//  Copyright © 2020 Derrick Park. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, WeatherManagerDelegate {
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    var city: City!
    var weatherManager = WeatherManager()
    
    @IBOutlet var cityTemp: UILabel!
    @IBOutlet var citySummary: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.delegate = self
        
        view.backgroundColor = .white
        view.addSubview(stackView)
        weatherManager.fetchWeather(cityName: city.name.lowercased())
        setupLayout()
    }
    
    func setupLayout() {
        // create stack view
        // set property
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually

        // set constraints
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100).isActive = true
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        // create labels
        cityTemp = createLabel(text: "Now Fetching Templature...", weight: .regular)
        citySummary = createLabel(text: "Now Fetching Templature...", weight: .regular)

        stackView.addArrangedSubview(createLabel(text: "Country", weight: .bold))
        stackView.addArrangedSubview(createLabel(text: city.countryFlag, weight: .regular))
        stackView.addArrangedSubview(createLabel(text: "City", weight: .bold))
        stackView.addArrangedSubview(createLabel(text: city.name, weight: .regular))
        stackView.addArrangedSubview(createLabel(text: "Temprature", weight: .bold))
        stackView.addArrangedSubview(cityTemp)
        stackView.addArrangedSubview(createLabel(text: "Summary", weight: .bold))
        stackView.addArrangedSubview(citySummary)
    }

    func createLabel(text: String, weight: UIFont.Weight) -> UILabel {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: weight)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = text
        return label
    }
    
    func didUpdateWeather(weather: WeatherModel) {
        DispatchQueue.main.async {
            self.cityTemp.text = weather.tempString
            self.citySummary.text = weather.conditionName
        }
    }

}
