//
//  PIxabayModel.swift
//  WeatherApp
//
//  Created by albert coelho oliveira on 10/15/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

struct Pixabay: Codable{
    let hits: [ImagesData]
}
struct ImagesData: Codable {
    let largeImageURL: String
}
