//
//  ViewController.swift
//  WeatherApp
//
//  Created by David Rifkin on 10/8/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var weather = [DataWrapper](){
        didSet{
            collectionTable.reloadData()
        }
    }
    var latAndLongHolder = ""{
        didSet{
                loadData(userInput: latAndLongHolder)
        }
    }
    @IBOutlet weak var userText: UITextField!
    @IBOutlet weak var collectionTable: UICollectionView!
    @IBOutlet weak var cityName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionTable.delegate = self
        collectionTable.dataSource = self
        userText.delegate = self
    }
    private func loadData(userInput: String?){
        WeatherFetch.manager.getWeather(latAndLong: userInput){ (result) in
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
    private func getWeather(zipcode: String){
        ZipCodeHelper.getLatLong(fromZipCode: zipcode) { (result) in
            DispatchQueue.main.async {
                switch result{
                case let .failure(error):
                    print(error)
                    let alert = UIAlertController(title: "Oh No Invalid Zip Code", message: "Please enter a valid Zip Code ", preferredStyle: .alert)
                    let cancelMessage = UIAlertAction(title: "Ok got it", style: .cancel) { (result) in
                        self.userText.text = ""
                    }
                    alert.addAction(cancelMessage)
                    self.present(alert,animated: true)
                   
                case let .success(lat,long,name):
                    self.cityName.text = name
                    self.latAndLongHolder = "\(lat.description),\(long.description)"
                }
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
             guard let weatherDetail = segue.destination as? DetailWeatherVCViewController else {
                 fatalError("Unexpected segue")
             }
           let selectedCell = sender as! WeatherCell
           let selectedIndexPath = (collectionTable.indexPath(for: selectedCell)?.row)!
        weatherDetail.weather = weather[selectedIndexPath]
        
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weather.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionTable.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as? WeatherCell
        let data = weather[indexPath.row]
        cell?.dateLabel.text = data.date
        cell?.weatherImage.image = UIImage(named: data.icon)
        cell?.highLabel.text = data.highTemp
        cell?.lowLabel.text = data.lowTemp
        print(data.icon)
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 340, height: 350)
    }
}
extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text{
        getWeather(zipcode: text)
    }
        return true
    }
}
