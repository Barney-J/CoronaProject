//
//  UserManager.swift
//  CoronaProject1
//
//  Created by Eugene Sushko on 11/5/20.
//

import Foundation


struct UserManager:Codable {
    private enum SettingsKey:String {
        case username
    }
    
    static var username:String! {
        get{
            return UserDefaults.standard.string(forKey: SettingsKey.username.rawValue)
        }set{
            let defaults = UserDefaults.standard
            let key = SettingsKey.username.rawValue
            if let name = newValue{
                defaults.setValue(name, forKey: key)
            }
        }
    }
}
