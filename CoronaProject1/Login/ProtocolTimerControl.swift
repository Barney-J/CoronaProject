import Foundation
import UIKit
import Swinject

protocol ProtocolTimerControl{
    func setStyle() -> StyleLoginVCManager
    var style: StyleLoginVCManager? {get set} 
}
