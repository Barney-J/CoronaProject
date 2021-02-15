import Foundation


struct UserManager:Codable {
    private enum SettingsKey:String {
        case username
    }
    
//MARK: SaveUserInLoginTextField
    static var username:String! {
        get {
            return UserDefaults.standard.string(forKey: SettingsKey.username.rawValue)
        } set {
            let defaults = UserDefaults.standard
            let key = SettingsKey.username.rawValue
            if let name = newValue{
                defaults.setValue(name, forKey: key)
            }
        }
    }
}
