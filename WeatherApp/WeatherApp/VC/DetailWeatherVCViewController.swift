//
//  DetailWeatherVCViewController.swift
//  WeatherApp
//
//  Created by albert coelho oliveira on 10/14/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class DetailWeatherVCViewController: UIViewController {
    var weather: DataWrapper?
    @IBOutlet weak var TitleLabel: UILabel!
      @IBOutlet weak var cityImage: UIImageView!
      @IBOutlet weak var highLabel: UILabel!
      @IBOutlet weak var lowLabel: UILabel!
      @IBOutlet weak var sunriseLabel: UILabel!
      @IBOutlet weak var sunsetLabel: UILabel!
      @IBOutlet weak var precipitation: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    private func loadData(){
        
    }
    
  
}
