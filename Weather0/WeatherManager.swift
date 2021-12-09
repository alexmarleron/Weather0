//
//  WeatherManager.swift
//  Weather0
//
//  Created by san on 04.10.2021.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_  weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherUrl = "https://api.weatherapi.com/v1/current.json?key=\(apiKey)&aqi=no"
    
    var delegate: WeatherManagerDelegate?

    func fetchWeather(cityName: String){
        let urlString = "\(weatherUrl)&q=\(cityName)"
        print(urlString)
        performRequest(with: urlString)
    }
    
    func performRequest(with urlsString: String) {
        //create URL
        if let url = URL(string: urlsString) {
            //create URL Session
            let session = URLSession(configuration: .default)
            //session task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJson(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
//                    let dataString = String(data: safeData, encoding: .utf8)
//                    print(dataString!)
                }
            }
            //start task
            task.resume()
        }
    }
    func parseJson(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
        let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
//            print(decodedData.current.temp_c)
            
            let temp = decodedData.current.temp_c
            let name = decodedData.location.name
            let codeId = decodedData.current.condition.code
            let description = decodedData.current.condition.text
            
            let weather = WeatherModel(conditionCode: codeId, cityName: name, temperature: temp, description: description)
            
            print(weather.conditionName)
//            print(weather.getConditionName(weatherCode: codeId))
//            print(decodedData.current.condition.text)
//            print(getConditionName(weatherCode: decodedData.current.condition.code))
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
