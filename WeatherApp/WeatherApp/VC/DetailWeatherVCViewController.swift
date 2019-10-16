//
//  DetailWeatherVCViewController.swift
//  WeatherApp
//
//  Created by albert coelho oliveira on 10/14/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class DetailWeatherVCViewController: UIViewController {
    var weatherData: DataWrapper?
    var city = String()
    var images: ImagesData?{
        didSet{
            getImage()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(stackLabels)
        constrainStackView()
        constrainImageView()
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    lazy var weatherInfo: UILabel = {
        var weatherInfo = UILabel()
        weatherInfo.text = weatherData?.summary
        return weatherInfo
    }()
    lazy var titleLabel: UILabel = {
        var titleLabel = UILabel()
        titleLabel.text = "Weather forcast for \(city) for \(weatherData!.date)"
        return titleLabel
    }()
    lazy var highLabel: UILabel = {
        var highLabel = UILabel()
        highLabel.text = weatherData?.highTemp
        return highLabel
    }()
    lazy var lowLabel: UILabel = {
        var lowLabel = UILabel()
        lowLabel.text = weatherData?.lowTemp
        return lowLabel
    }()
    lazy var sunriseLabel: UILabel = {
        var sunriseLabel = UILabel()
        sunriseLabel.text = weatherData?.timeSunRise
        return sunriseLabel
    }()
    lazy var sunsetLabel: UILabel = {
        var sunsetLabel = UILabel()
        sunsetLabel.text = weatherData?.timeSunset
        return sunsetLabel
    }()
    lazy var precipitation: UILabel = {
        var precipitation = UILabel()
        precipitation.text =  "Inches of Precipitation: \(weatherData!.precipIntensityMax.description)"
        return precipitation
    }()
    lazy var cityImage: UIImageView = {
        var cityImage = UIImageView()
        return cityImage
    }()
    lazy var saveButton: UIBarButtonItem = {
        var saveButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: nil, action: #selector(saveAction(sender:)))
        return saveButton
    }()
    @IBAction func saveAction(sender: UIButton) {
          //    guard let imageData = self.cityImage.image?.jpegData(compressionQuality: 0.5)
        //    //        else {return}
        //    //    let date = Date().description
        //    //    let photoData = Photo(date: date, image: imageData)
        //    //    try?
        //    //        ImagePersistence.manager.saveImage(info: photoData)
        //    //}
    }
    
    
    lazy var stackLabels: UIStackView = {
        let stackLabels = UIStackView(arrangedSubviews: [titleLabel,weatherInfo,highLabel,lowLabel,sunriseLabel,sunsetLabel,precipitation])
        stackLabels.axis = .vertical
        stackLabels.alignment = .center
        stackLabels.distribution = .fillProportionally
        stackLabels.spacing = 5
        return stackLabels
    }()
    private func constrainStackView() {
        stackLabels.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackLabels.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackLabels.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            stackLabels.heightAnchor.constraint(equalToConstant: 400),
            stackLabels.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }
    private func constrainImageView(){
        view.addSubview(cityImage)
        cityImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cityImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            cityImage.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -190),
            cityImage.heightAnchor.constraint(equalToConstant: 365),
            cityImage.widthAnchor.constraint(equalTo: self.view.widthAnchor)
        ])
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
        weatherInfo.text = weatherData?.summary
        titleLabel.text = "\(city)  \(weatherData!.date)"
        highLabel.text = weatherData?.highTemp
        lowLabel.text = weatherData?.lowTemp
        sunriseLabel.text = weatherData?.timeSunRise
        sunsetLabel.text = weatherData?.timeSunset
        precipitation.text = "Inches of Precipitation: \(weatherData!.precipIntensityMax.description)"
    }
}

