//
//  WeatherModel.swift
//  Weather0
//
//  Created by san on 25.10.2021.
//

import Foundation

struct WeatherModel {
    let conditionCode: Int
    let cityName: String
    let temperature: Double
    let description: String
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }

    var conditionName: String {
        //    func getConditionName(weatherCode: Int) -> String {
        //        switch weatherCode {
        switch conditionCode {
        case 1000:
            return "sun.max"
        case 1003:
            return "cloud.sun"
        case 1006, 1009:
            return "cloud"
        case 1030, 1147:
            return "cloud.fog"
        case 1063, 1180, 1186, 1192, 1240...1246:
            return "cloud.sun.rain"
        case 1066:
            return "snowflake"
        case 1069, 1249, 1252:
            return "cloud.sleet"
        case 1072, 1198, 1201, 1237:
            return "cloud.hail" //light freezing rain
        case 1087, 1273:
            return "cloud.sun.bolt"
        case 1114, 1210...1225, 1255...1264:
            return "cloud.snow"
        case 1117:
            return "cloud.snow.fill"
        case 1150...1171:
            return "cloud.drizzle"
        case 1183, 1189:
            return "cloud.rain"
        case 1195:
            return "cloud.heavyrain"
        case 1204...1207:
            return "cloud.sleet"
        case 1276:
            return "cloud.bolt"
        case 1279, 1282:
            return "cloud.bolt.rain"
        default:
            return "cloud"
        }
        //        }
    }
}
