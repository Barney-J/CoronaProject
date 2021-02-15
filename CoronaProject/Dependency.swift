import Foundation
import Swinject


class Dependency {
    static var container: Container!
    
    static func registerDependency () {
        container.register(FieldValidator.self) {_ in
            let complexLogPassFieldValidator = ComplexLogPassFieldValidator()
            let passwordValidator = AttemptsCountValidator(fieldValidator: complexLogPassFieldValidator)
            return passwordValidator}
        container.register(StyleLoginVCManager.self, name: "Light") { _ in LightStyle()}
        container.register(StyleLoginVCManager.self, name: "Dark") { _ in DarkStyle()}
        container.register(ProtocolTimerControl.self) { _ in TimerControl()}
        container.register(ModelView.self) {_ in
            let complexLogPassFieldValidator = ComplexLogPassFieldValidator()
            let loginModelView = LoginModelView(validator: complexLogPassFieldValidator)
            return loginModelView
        }
//        container.register(EventManager.self) {_ in ListEventManager()}.inObjectScope(.container)
    }
}
