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
    var city = String()
    var images: ImagesData?{
        didSet{
            getImage()
            loadLabels()
        }}
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        guard let imageData = self.cityImage.image?.jpegData(compressionQuality: 0.5)
            else {return}
        let date = Date().description
        let photoData = Photo(date: date, image: imageData)
        try?
            ImagePersistence.manager.saveImage(info: photoData)
    }
    @IBOutlet weak var weatherInfo: UILabel!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var cityImage: UIImageView!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var precipitation: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataPixabay()
    }
    private func loadDataPixabay(){
        ImagesFetch.manager.getImages(named: city) { (result) in
            DispatchQueue.main.async {
                switch result{
                case .failure(let error):
                    print(error)
                case .success(let imageData):
                    self.images = imageData
                } 
            }
        }
    }
    private func getImage(){
        ImageHelper.shared.fetchImage(urlString: images!.largeImageURL) { (result) in
            DispatchQueue.main.async {
                switch result{
                case .failure(let error):
                    print(error)
                case .success(let imageData):
                    self.cityImage.image = imageData
                }
            }
        }
    }
    private func loadLabels(){
        weatherInfo.text = weather?.summary
        TitleLabel.text = "Weather forcast for \(city) for \(weather!.date)"
        highLabel.text = weather?.highTemp
        lowLabel.text = weather?.lowTemp
        sunriseLabel.text = weather?.timeSunRise
        sunsetLabel.text = weather?.timeSunset
        precipitation.text = "Inches of Precipitation: \(weather!.precipIntensityMax.description)"
    }
}
