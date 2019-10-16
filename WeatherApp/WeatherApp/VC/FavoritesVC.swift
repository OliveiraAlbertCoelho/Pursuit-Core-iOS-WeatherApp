//
//  FavoritesVC.swift
//  WeatherApp
//
//  Created by albert coelho oliveira on 10/15/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class FavoritesVC: UIViewController {
    var favorite = [Photo](){
        didSet{
            favoriteTable.reloadData()
        }
    }
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
    @IBOutlet weak var favoriteTable: UICollectionView!
    private func loadUserFavorites(){
        do {
            favorite = try ImagePersistence.manager.getImage()
        }catch{
            print(error)
        }
    }
 
}
extension FavoritesVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(favorite.count)
        return favorite.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = favoriteTable.dequeueReusableCell(withReuseIdentifier: "favCell", for: indexPath) as! FavoriteCell
        let data = favorite[indexPath.row]
        cell.favoriteImage.image = UIImage(data: data.image)
        print(data.dateFormat)
        cell.dateLabel.text = data.dateFormat
        return cell
    }

    
}

