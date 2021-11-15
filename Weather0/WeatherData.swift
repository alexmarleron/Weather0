//
//  WeatherData.swift
//  Weather0
//
//  Created by san on 13.10.2021.
//

import Foundation

struct WeatherData:Codable {
//    let data: String
    let current: Current
    let location: Location
}

struct Location: Codable {
    let name: String
}
struct Current: Codable {
    let temp_c: Double
    let condition: Condition
}
struct Condition: Codable {
    let text: String
    let code: Int
}
