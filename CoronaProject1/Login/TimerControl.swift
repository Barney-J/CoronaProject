import Foundation
import UIKit

class TimerControl: ProtocolTimerControl{
    
    public var style: StyleLoginVCManager?
    
    public func setStyle() -> StyleLoginVCManager {
        if (timerControl() == true){
            style = Dependency.container.resolve(StyleLoginVCManager.self, name: "Light")
        }else if (timerControl() == false){
            style = Dependency.container.resolve(StyleLoginVCManager.self, name: "Dark")
        }
        return style!
    }
    
    private func timerControl() -> Bool{
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component( .hour , from: date)
        if hour <= 18 && hour >= 8 {
            return true
        }else{
            return false
        }
    }
}

//public func setStyle(_ loginTextField: UITextField,_ view: UIView){
//    if (timerControl() == true){
//        let conteinerStyle = Dependency.container.resolve(StyleLoginVCManager.self, name: "Light")
//        view.backgroundColor = conteinerStyle?.bgColor
//        loginTextField.textColor = conteinerStyle?.textColor
//
//    }else if (timerControl() == false){
//        let conteinerStyle = Dependency.container.resolve(StyleLoginVCManager.self, name:"Dark" )
//        view.backgroundColor = conteinerStyle?.bgColor
//        loginTextField.textColor = conteinerStyle?.textColor
//    }
//}
