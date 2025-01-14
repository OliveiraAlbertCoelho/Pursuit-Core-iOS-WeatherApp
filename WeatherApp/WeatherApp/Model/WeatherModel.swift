//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by albert coelho oliveira on 10/11/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

struct WeatherWrapper: Codable{
    let daily: Weather
    static func decodeWeather(from jsonData: Data) throws -> WeatherWrapper{
        let response = try JSONDecoder().decode(WeatherWrapper.self, from: jsonData)
        return response
    }
}
struct Weather: Codable {
    let summary: String
    let icon: String
    let data: [DataWrapper]
}

struct DataWrapper: Codable{
    let time: Int
    let summary: String
    let icon: String
    let temperatureHigh: Double
    let temperatureLow: Double
    let sunriseTime: Int
    let sunsetTime: Int
    let windSpeed: Double
    let precipIntensityMax: Double
  
    var date : String {
        get {
            let date = NSDate(timeIntervalSince1970: TimeInterval(time)) as Date
            let df = DateFormatter()
            df.dateFormat = "MMM dd, yyyy"
            return df.string(from:date)
        }
    }
    var timeSunset : String {
        get {
            let date = NSDate(timeIntervalSince1970: TimeInterval(sunsetTime)) as Date
            let df = DateFormatter()
            df.dateFormat = "hh:mm a"
            return "Sunset: \(df.string(from:date))"
        }
    }
    
    var timeSunRise : String {
        get {
            let date = NSDate(timeIntervalSince1970: TimeInterval(sunriseTime)) as Date
            let df = DateFormatter()
            df.dateFormat = "hh:mm a"
            return "Sunrise \(df.string(from:date))"
        }
    }
    var highTemp : String {
        get{
            return "High: \(temperatureHigh)º F"
        }
    }
    var lowTemp : String {
          get{
              return "Low: \(temperatureLow)º F"
          }
      }
}
