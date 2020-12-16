//
//  Weather.swift
//  Assignment4
//
//  Created by 杉原大貴 on 2020/12/16.
//  Copyright © 2020 Derrick Park. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather( weatherManager: WeatherManager, weather: WeatherModel)
}

struct WeatherManager {
    
    let url: String = "https://api.openweathermap.org/data/2.5/weather?appid=89cfc212ed2018dc3d12026ccde01476"

    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        print("****** [\(#function)] Run ******")
        let urlString = "\(url)&q=\(cityName)"
        let newUrl = urlString.replacingOccurrences(of: " ", with: "%20")
        performRequest(urlString: newUrl)
    }
    
    func performRequest(urlString: String) {
        print("****** [\(#function)] Run ******")
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(weatherData: safeData) {
                        self.delegate?.didUpdateWeather(weatherManager: self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        print("****** [\(#function)] Run ******")
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let description = decodedData.weather[0].description

            let weather = WeatherModel(conditionId: id, temp: temp, description: description)
            return weather
        } catch {
            return nil
        }
    }
}
