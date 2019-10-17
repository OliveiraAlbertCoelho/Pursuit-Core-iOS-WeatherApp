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
        guard let path = Bundle.main.path(forResource: "jsonWeather", ofType: "json") else { return }
        var jsonData = Data()
        do {
            jsonData = try Data(contentsOf: URL(fileURLWithPath: path))
        }catch{
            print(error)
            XCTFail()
        }
        var weather = [DataWrapper]()
        do {
            let weatherData = try WeatherWrapper.decodeWeather(from: jsonData)
            weather = weatherData.daily.data
        }
        catch{
            print(error)
            XCTFail()
        }
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
