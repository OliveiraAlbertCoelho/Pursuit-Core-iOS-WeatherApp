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

    func getWeather(completionHandler: @escaping (Result<[Film], AppError>) -> ()) {
            let urlStr = "https://ghibliapi.herokuapp.com/films"
            guard let url = URL(string: urlStr) else {
                completionHandler(.failure(.badURL))
                return
            }
            
            NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
                switch result {
                case .failure(let error) :
                    completionHandler(.failure(error))
                case .success(let data):
                    do {
                    let films = try JSONDecoder().decode([Film].self, from: data)
                    completionHandler(.success(films))
                    } catch {
                        print(error)
                        completionHandler(.failure(.other(rawError: error)))
                    }
                }
            }
            
            
        }
    }
