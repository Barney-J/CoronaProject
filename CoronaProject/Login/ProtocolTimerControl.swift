import Foundation
import Swinject

protocol ProtocolTimerControl{
    func setStyle() -> StyleLoginVCManager
    var style: StyleLoginVCManager? {get}
}
