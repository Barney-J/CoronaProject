import Foundation
import UIKit

class TimerControl: ProtocolTimerControl{
    public func setStyle(_ loginTextField: UITextField,_ view: UIView){
        if (timerControl() == true){
            let conteinerStyle = Dependency.conteiner.resolve(StyleLoginVCManager.self, name: "Light")
            view.backgroundColor = conteinerStyle?.bgColor
            loginTextField.textColor = conteinerStyle?.textColor

        }else if (timerControl() == false){
            let conteinerStyle = Dependency.conteiner.resolve(StyleLoginVCManager.self, name:"Dark" )
            view.backgroundColor = conteinerStyle?.bgColor
            loginTextField.textColor = conteinerStyle?.textColor
        }
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
