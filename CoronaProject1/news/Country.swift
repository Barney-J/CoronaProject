import Foundation

struct Country: Codable {
    var country: String
    var latest: Latest
    init(_ country: String , _ latest: Latest) {
        self.country = country
        self.latest = latest
    }
    
    static let countryList = [
        "Belarus",
        "Usa",
        "Germany"
    ]
    
//    static func goCountry() -> [Country] {
//        var addCountry = [Country]()
//        for country in countryList {
//            addCountry.append(Country(country, ))
//        }
//        return addCountry
//    }
}




struct Latest: Codable {
    var confirmed: Int
    var deaths: Int
    
    init(_ confirmed: Int ,_ deaths: Int) {
        self.confirmed = confirmed
        self.deaths = deaths
    }
    static let confirmedList = [
        153,
        145,
        1253
    ]
    static let deathList = [
        10,
        15,
        8
    ]
    
    static func getConfirmed() -> [Latest] {
        var addConfirmedLabel = [Latest]()
        for confirmed in confirmedList{
            addConfirmedLabel.append(Latest(confirmed, 0 ))
        }
        return addConfirmedLabel
    }
    
    static func getDeath() -> [Latest] {
        var addDeathLabel = [Latest]()
        for death in deathList{
            addDeathLabel.append(Latest(0, death ))
        }
        return addDeathLabel
    }
}
