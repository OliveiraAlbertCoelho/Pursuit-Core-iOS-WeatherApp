//
//  ImagePersistence.swift
//  Photo-Journal-Project
//
//  Created by albert coelho oliveira on 10/3/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import Foundation

struct ImagePersistence{
    private init(){}
    static let manager = ImagePersistence()
    private let persistenceHelper = PersistenceHelper<Photo>(fileName: "imageData.plist")
    
    func getImage() throws -> [Photo]{
        return try persistenceHelper.getObjects().reversed()
    }
    func saveImage(info: Photo) throws{
        try persistenceHelper.save(newElement: info)
    }
    func deleteImage(Int: Int) throws{
        try persistenceHelper.delete(num: Int)
    }
    func editImage(Int: Int, newElement: Photo) throws{
        try persistenceHelper.edit(num: Int, newElement: newElement)
    }
    
}
