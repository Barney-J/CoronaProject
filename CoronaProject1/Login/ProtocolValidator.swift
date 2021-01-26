import Foundation

protocol FieldValidator  {
    func checkLoginAndPassword (_ login: String ,_ password: String) -> Bool
    func passwordValidator(_ password: String) -> Bool
}
