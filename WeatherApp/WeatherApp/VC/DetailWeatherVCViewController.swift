//
//  DetailWeatherVCViewController.swift
//  WeatherApp
//
//  Created by albert coelho oliveira on 10/14/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class DetailWeatherVCViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        weatherImage.image = UIImage(named: "movingSnow")
    }
    @IBOutlet weak var weatherImage: UIImageView!
    
    

}
