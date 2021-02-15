import Foundation

protocol EventManager{
    func subscribe( listened: Listener)
    func notify()
}

protocol Listener {
    func update()
}

enum  EventType {
    case logout
}

class ListEventManager:EventManager{
    private var listeners = [Listener]()

    func subscribe(listened: Listener) {
        listeners.append(listened)
    }

    func notify() {
        listeners.forEach { listeners in
            listeners.update()
        }
    }
}

class Logger:Listener{
    init(eventManager: EventManager) {
        eventManager.subscribe(listened: self)
    }
    func update() {
        print("did logout")
    }
}
