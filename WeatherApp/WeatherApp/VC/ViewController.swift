//
//  ViewController.swift
//  WeatherApp
//
//  Created by David Rifkin on 10/8/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//
import MapKit
import CoreLocation
import UIKit

class ViewController: UIViewController {
    
    var locationManager = CLLocationManager()
    var userLocationprivacy = ""
    var userStoredLocation = String(){
        didSet{
            loadData(userInput: userStoredLocation)
        }
    }
    @IBOutlet weak var userText: UITextField!
    @IBOutlet weak var collectionTable: UICollectionView!
    @IBOutlet weak var cityName: UILabel!
    
    var weather = [DataWrapper](){
        didSet{
            collectionTable.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getAutho()
        setModeFromUserDefaults()
        loadDataUserDefault()
        setDelegates()
        setUpObservers()
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
                    let alert = UIAlertController(title: "Error", message: "Please enter a valid address ", preferredStyle: .alert)
                    let cancelMessage = UIAlertAction(title: "Ok got it", style: .cancel) { (result) in
                        self.userText.text = ""
                    }
                    alert.addAction(cancelMessage)
                    self.present(alert,animated: true)
                case let .success(lat,long,name):
                    self.cityName.text = "\(name)"
                    self.userStoredLocation = "\(lat.description),\(long.description)"
                }
            }
        }
    }
    private func loadDataUserDefault(){
        if let text = userText.text {
            getWeather(zipcode: text)
        }
    }
    private func setDelegates(){
        collectionTable.delegate = self
        collectionTable.dataSource = self
        userText.delegate = self
    }
    
    private func setModeFromUserDefaults(){
        if let mode = UserDefaultWrapper.manager.getMode() {
            userText.text = mode
        }
    }
    private func getAutho(){
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    @IBAction func getUserLocation(_ sender: UIButton) {
        getWeather(zipcode: userLocationprivacy)
        UserDefaultWrapper.manager.store(mode: cityName.text!)
    }
    func setUpObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc   func keyboardWillHide() {
        self.view.frame.origin.y = 0
    }

    @objc  func keyboardWillChange(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if userText.isFirstResponder {
                self.view.frame.origin.y  = -keyboardSize.height
            }
        }
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
        cell?.layer.borderWidth = 5
        cell?.layer.borderColor = CGColor(srgbRed: 0.682, green: 0.809, blue: 0.663, alpha: 1.0)
        print(data.icon)
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 340, height: 350)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc: DetailWeatherVCViewController = DetailWeatherVCViewController()
        vc.SelectedweatherData = weather[indexPath.row]
        vc.city = cityName.text!
        vc.latLong = userStoredLocation
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text{
            UserDefaultWrapper.manager.store(mode:text)
            getWeather(zipcode: text)
        }
        textField.resignFirstResponder()
        return true
    }
    
    
    
}
extension ViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        userLocationprivacy = "\(locValue.latitude),\(locValue.longitude)"
    }
    
}
