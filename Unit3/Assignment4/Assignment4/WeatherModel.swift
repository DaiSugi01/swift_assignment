//
//  WeatherModel.swift
//  Assignment4
//
//  Created by 杉原大貴 on 2020/12/16.
//  Copyright © 2020 Derrick Park. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let temp: Double
    let description: String
    
    var tempString: String {
        let celsius = self.temp - 273.15
        return String(format: "%.1f", celsius)
    }

    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "Thunderstorm"
        case 300...321:
            return "Drizzle"
        case 500...531:
            return "Rain"
        case 600...622:
            return "Snow"
        case 701:
            return "Mist"
        case 711:
            return "Smoke"
        case 721:
            return "Haze"
        case 731:
            return "Dust"
        case 741:
            return "Fog"
        case 751:
            return "Sand"
        case 761:
            return "Dust"
        case 762:
            return "Ash"
        case 771:
            return "Squall"
        case 781:
            return "Tornado"
        case 800:
            return "Sunny"
        default:
            return "Clouds"
        }
    }
}
