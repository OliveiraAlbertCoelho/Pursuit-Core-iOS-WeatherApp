//
//  FavoriteWeatherModel.swift
//  WeatherApp
//
//  Created by albert coelho oliveira on 10/17/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation


struct FavoriteWeahter: Codable{
    let cityName: String
    let weatherInfo: DataWrapper
    let latAndLong: String
    let photo: Data
}


