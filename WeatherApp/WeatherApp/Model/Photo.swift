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
    let id: Int
    var dateFormat: String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss z"
        let date = dateFormatter.date(from: self.date)
        dateFormatter.dateFormat = "MMM dd, yyyy  HH:MM a"
        return  dateFormatter.string(from: date!)
    }
    func checkFavorites() -> Bool? {
        do {
            let savedImages = try ImagePersistence.manager.getImage()
            if savedImages.contains(where: {$0.id == self.id}) {
                return true
            } else {
                return false
            }
        } catch {
            print(error)
            return nil
        }
    }
}
