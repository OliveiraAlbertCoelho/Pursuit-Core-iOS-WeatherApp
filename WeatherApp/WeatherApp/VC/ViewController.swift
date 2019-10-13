//
//  ViewController.swift
//  WeatherApp
//
//  Created by David Rifkin on 10/8/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var weather = [Weather](){
        didSet{
            collectionTable.reloadData()
        }
    }
    @IBOutlet weak var collectionTable: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private func loadData(){
        WeatherFetch.manager.getWeather { (result) in
            DispatchQueue.main.async {
                switch result{
                case .failure(let error):
                print(error)
                case .success(let weather):
                    self.weather = weather
                }
            }
        }
    }
    

}

