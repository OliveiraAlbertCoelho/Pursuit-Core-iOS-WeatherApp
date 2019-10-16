//
//  Photo.swift
//  WeatherApp
//
//  Created by albert coelho oliveira on 10/15/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

struct Photo: Codable{
    let date: String
    let image: Data
    
    var dateFormat: String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss z"
        let date = dateFormatter.date(from: self.date)
        dateFormatter.dateFormat = "MMM dd, yyyy  HH:MM a"
        return  dateFormatter.string(from: date!)
    }
}
