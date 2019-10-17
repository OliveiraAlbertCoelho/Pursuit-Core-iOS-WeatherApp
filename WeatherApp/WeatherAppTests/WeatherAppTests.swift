//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by albert coelho oliveira on 10/17/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import XCTest

class WeatherAppTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testWeatherFromJson() {
              guard let jsonPath = Bundle.main.path(forResource: "weatherJson", ofType: "json") else {
                fatalError("JSON file not found")
            }
            
            var jsonData = Data()
            do {
                jsonData = try Data(contentsOf: URL(fileURLWithPath: jsonPath))
            } catch {
                print(error)
                XCTFail()
            }
            
            // Act
        var forecast = [DataWrapper]()
            do {
                let weatherInfo = try WeatherWrapper.decodeWeather(from: jsonData)
                    forecast = weatherInfo.daily.data
            }
            catch {
                print(error)
                XCTFail()
            }
                
            // Assert
            XCTAssertTrue(forecast.count == 8, "Was expecting 8 elements, but found \(forecast.count)")
        }
    
}
