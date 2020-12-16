//
//  WeatherData.swift
//  Assignment4
//
//  Created by 杉原大貴 on 2020/12/16.
//  Copyright © 2020 Derrick Park. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Weather: Codable {
    let id: Int
    let description: String
    
}

struct Main: Codable {
    let temp: Double
}
