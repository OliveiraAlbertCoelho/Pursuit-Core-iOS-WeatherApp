//
//  UserDefaultWrapper.swift
//  Photo-Journal-Project
//
//  Created by albert coelho oliveira on 10/7/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import Foundation

class UserDefaultWrapper {
    static let manager = UserDefaultWrapper()
    
    func store(mode: String) {
        UserDefaults.standard.set(mode, forKey: modeKey)
    }
    func getMode() -> String? {
        return UserDefaults.standard.value(forKey: modeKey) as? String
    }
    private init() {}
    private let modeKey = "mode"
}
