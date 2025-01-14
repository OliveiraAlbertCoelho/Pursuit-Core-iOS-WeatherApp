//
//  DetailWeatherVCViewController.swift
//  WeatherApp
//
//  Created by albert coelho oliveira on 10/14/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class DetailWeatherVCViewController: UIViewController {
    var SelectedweatherData: DataWrapper?
    var city = String()
    var latLong = String()
    var images: ImagesData?{
        didSet{
            getImage()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataPixabay()
        SetUpView()
        constrainStackView()
        constrainImageView()
    }
    
    lazy var weatherInfo: UILabel = {
        var weatherInfo = UILabel()
        weatherInfo.textColor = .white
        weatherInfo.text = SelectedweatherData?.summary
        return weatherInfo
    }()
    lazy var titleLabel: UILabel = {
        var titleLabel = UILabel()
        titleLabel.textColor = .white
        titleLabel.text = "\(city)  \(SelectedweatherData!.date)"
        return titleLabel
    }()
    lazy var highLabel: UILabel = {
        var highLabel = UILabel()
        highLabel.textColor = .white
        highLabel.text = SelectedweatherData?.highTemp
        return highLabel
    }()
    lazy var lowLabel: UILabel = {
        var lowLabel = UILabel()
        lowLabel.textColor = .white
        lowLabel.text = SelectedweatherData?.lowTemp
        return lowLabel
    }()
    lazy var sunriseLabel: UILabel = {
        var sunriseLabel = UILabel()
        sunriseLabel.text = SelectedweatherData?.timeSunRise
        sunriseLabel.textColor = .white
        return sunriseLabel
    }()
    lazy var sunsetLabel: UILabel = {
        var sunsetLabel = UILabel()
        sunsetLabel.textColor = .white
        sunsetLabel.text = SelectedweatherData?.timeSunset
        return sunsetLabel
    }()
    lazy var precipitation: UILabel = {
        
        var precipitation = UILabel()
        precipitation.textColor = .white
        precipitation.text =  "Inches of Precipitation: \(SelectedweatherData!.precipIntensityMax.description)"
        return precipitation
    }()
    lazy var cityImage: UIImageView = {
        var cityImage = UIImageView()
        return cityImage
    }()
    lazy var saveButton: UIBarButtonItem = {
        var saveButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(saveAction(sender:)))
        return saveButton
    }()
    @IBAction func saveAction(sender: UIBarButtonItem) {
        guard let imageData = self.cityImage.image?.jpegData(compressionQuality: 0.5)
            else {return}
        let date = Date().description
        
        let photoData = Photo(date: date, image: imageData, id: images!.id)
        
        let optionsMenu = UIAlertController.init(title: "Options", message: "Pick an Option", preferredStyle: .actionSheet)
        let saveImage = UIAlertAction.init(title: "Save image", style: .default) { (action) in
            if photoData.checkFavorites()!{
                let alert = UIAlertController(title: "", message: "Oops you have saved this image before", preferredStyle: .alert)
                let cancelMessage = UIAlertAction(title: "Ok got it", style: .cancel)
                alert.addAction(cancelMessage)
                self.present(alert,animated: true)
            }else {
                try?
                    ImagePersistence.manager.saveImage(info: photoData)
                
                let alert = UIAlertController(title: "", message: "Saved", preferredStyle: .alert)
                self.present(alert,animated: true)
                alert.dismiss(animated: true, completion: nil)
            }}
        
        let saveWeather = UIAlertAction.init(title: "SaveWeather", style: .default) {
            (action) in
            let weatherData = FavoriteWeahter(cityName: self.city, weatherInfo: self.SelectedweatherData!, latAndLong: self.latLong , photo: imageData)
          try?  favoriteWeatherPersistence.manager.saveImage(info: weatherData)
        }
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
           optionsMenu.addAction(saveImage)
        optionsMenu.addAction(saveWeather)
        optionsMenu.addAction(cancelAction)
        present(optionsMenu, animated: true, completion: nil)
        
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
        view.addSubview(stackLabels)
        stackLabels.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackLabels.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackLabels.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            stackLabels.heightAnchor.constraint(equalToConstant: 350),
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
    private func SetUpView(){
        view.backgroundColor = UIColor(displayP3Red: CGFloat(0.559), green: CGFloat(0.716), blue: CGFloat(0.839), alpha: CGFloat(1.0))
        self.navigationItem.rightBarButtonItem = saveButton
    }
}

