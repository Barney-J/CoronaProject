import Foundation
import Swinject


class Dependecies {
    static var container: Container!
    
    static func registerDependecies () {
        container.register(FieldValidator.self) {_ in
            let complexLogPassFieldValidator = ComplexLogPassFieldValidator()
            let attemptsCountValidator = AttemptsCountValidator(fieldValidator: complexLogPassFieldValidator)
            return attemptsCountValidator}
        container.register(StyleLoginVCManager.self, name: "Light") { _ in LightStyle()}
        container.register(StyleLoginVCManager.self, name: "Dark") { _ in DarkStyle()}
        container.register(ProtocolTimerControl.self) { _ in TimerControl()}
        container.register(EventManager.self) {_ in ListEventManager()}.inObjectScope(.container)
    }
}
