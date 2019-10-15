//
//  ImagesFetch.swift
//  WeatherApp
//
//  Created by albert coelho oliveira on 10/15/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

class ImagesFetch {

 
    static let manager = ImagesFetch()

    func getImages(named: String,completionHandler: @escaping (Result<ImagesData, AppError>) -> ()) {
        let formatedString = named.replacingOccurrences(of: " ", with: "+")
        let urlString = "https://pixabay.com/api/?key=\(Secretes.pixabayKey)&q=\(formatedString)"
        print(urlString)
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
                    let data = try JSONDecoder().decode(Pixabay.self, from: data)
                        let random = Int.random(in: 0...data.hits.count-1)
                        completionHandler(.success(data.hits[random]))
                    } catch {
                        print(error)
                        completionHandler(.failure(.other(rawError: error)))
                    }
                }
            }
            
            
        }
    
    }
