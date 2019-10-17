//
//  FavoritesWeatherVC.swift
//  WeatherApp
//
//  Created by albert coelho oliveira on 10/17/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class FavoritesWeatherVC: UIViewController {

    var weather = [FavoriteWeahter](){
        didSet{
            favoriteTable.reloadData()
        }
    }
    @IBOutlet weak var favoriteTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       loadUserFavorites()
        favoriteTable.delegate = self
        favoriteTable.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadUserFavorites()
    }
    private func loadUserFavorites(){
            do {
                weather = try favoriteWeatherPersistence.manager.getImage()
            }catch{
                print(error)
            }
        }
}
extension FavoritesWeatherVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weather.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoriteTable.dequeueReusableCell(withIdentifier: "favCell", for: indexPath)as! favoriteWeatherCellTableViewCell
        let data = weather[indexPath.row]
        cell.cityName.text = data.cityName
        cell.weatherImage.image = UIImage(data: data.photo)
        return cell
    }
}
