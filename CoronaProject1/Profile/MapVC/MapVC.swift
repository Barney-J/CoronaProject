import UIKit
import CoreLocation
import UserNotifications
import CoreLocation


class MapVC: UIViewController {
    
    let center = UNUserNotificationCenter.current()
     let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
        }
        locationManager.requestAlwaysAuthorization()
        locationManager.startMonitoringVisits ()
        locationManager.delegate = self

        
    }
    
}

extension AppDelegate: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didVisit visit: CLVisit) {
    // create CLLocation from the coordinates of CLVisit
    let clLocation = CLLocation(latitude: visit.coordinate.latitude, longitude: visit.coordinate.longitude)

    // Get location description
  }

  func newVisitReceived(_ visit: CLVisit, description: String) {
    let location = Location(visit: visit, descriptionString: description)

    // Save location to disk
  }
}

