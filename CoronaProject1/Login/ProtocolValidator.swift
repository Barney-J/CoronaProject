import Foundation

protocol FieldValidator  {
    func checkLoginAndPassword (_ login: String ,_ password: String) -> Bool
}
