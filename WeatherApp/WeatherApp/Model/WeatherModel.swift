//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by albert coelho oliveira on 10/11/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

struct WeatherWrapper: Codable{
    let currently: Weather
}
struct Weather: Codable {
    let summary: String
    let icon: String
}
