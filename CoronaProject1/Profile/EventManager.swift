//import Foundation
//
//protocol EventManager{
//    func subscribe(event: EventType, listened: Listener)
//    func notify(event: EventType)
//}
//
//protocol Listener {
//    func update()
//}
//
//enum  EventType {
//    case logout , login
//}
//
//class ListEventManager:EventManager{
//    private var listeners = [Listener]()
//    
//    func subscribe(event: EventType, listened : Listener) {
//        listeners.append(listened)
//    }
//    
//    func notify(event: EventType) {
//        listeners.forEach { listeners in
//            listeners.update()
//        }
//    }
//}
//
//class Logger:Listener{
//    init(eventManager: EventManager) {
//        eventManager.subscribe (event: <#EventType#>, listened: self)
//    }
//    func update() {
//        print("did logout")
//        
//    }
//}
//
