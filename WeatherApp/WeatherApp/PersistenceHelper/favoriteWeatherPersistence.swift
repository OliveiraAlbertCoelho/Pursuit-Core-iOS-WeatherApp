//
//  favoriteWeatherPersistence.swift
//  WeatherApp
//
//  Created by albert coelho oliveira on 10/17/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

struct favoriteWeatherPersistence{
        private init(){}
        static let manager = favoriteWeatherPersistence()
        private let persistenceHelper = PersistenceHelper<FavoriteWeahter>(fileName: "weatherData.plist")
        
        func getImage() throws -> [FavoriteWeahter]{
            return try persistenceHelper.getObjects().reversed()
        }
        func saveImage(info: FavoriteWeahter) throws{
            try persistenceHelper.save(newElement: info)
        }
        func deleteImage(Int: Int) throws{
            try persistenceHelper.delete(num: Int)
    }
    }

