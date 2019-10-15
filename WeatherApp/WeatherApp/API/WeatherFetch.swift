//
//  WeatherFetch.swift
//  WeatherApp
//
//  Created by albert coelho oliveira on 10/11/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

class WeatherFetch {

 
    static let manager = WeatherFetch()

    func getWeather(latAndLong: String?,completionHandler: @escaping (Result<[DataWrapper], AppError>) -> ()) {
        
        var urlString = "https://api.darksky.net/forecast/\(Secretes.apiKey)/37.8267,-122.4233"
        if let userInfo = latAndLong{
            urlString = "https://api.darksky.net/forecast/\(Secretes.apiKey)/\(userInfo)"
        }
       
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.badURL))
                      return
                  }
            NetworkHelper.manager.performDataTask(withUrl: url , andMethod: .get) { (result) in
                switch result {
                case .failure(let error) :
                    completionHandler(.failure(error))
                case .success(let data):
                    do {
                    let weather = try JSONDecoder().decode(WeatherWrapper.self, from: data)
                        completionHandler(.success(weather.daily.data))
                    } catch {
                        print(error)
                        completionHandler(.failure(.other(rawError: error)))
                    }
                }
            }
            
            
        }
    
    }
