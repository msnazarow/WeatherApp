//
//  WeatherCity.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 04.09.2021.
//

import Foundation

struct WeatherCity: Codable {
    let lattLong: String
    let locationType: String
    let title: String
    let woeid: Int
}

struct City {
    let lattLong: [Double]
    let locationType: String
    let title: String
    let woeid: Int
    init(_ weatherCity: WeatherCity) {
        locationType = weatherCity.locationType
        title = weatherCity.title
        woeid = weatherCity.woeid
        lattLong = weatherCity.lattLong.components(separatedBy: ", ").map {
            Double($0.trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0
        }
    }
}
