//import UIKit
//import CoreLocation
//import UserNotifications
//import CoreLocation
//
//
//class MapVC: UIViewController {
//
//    static let geoCoder = CLGeocoder()
//    let center = UNUserNotificationCenter.current()
//    let locationManager = CLLocationManager()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.navigationController?.isNavigationBarHidden = false
//        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
//        }
//        locationManager.requestAlwaysAuthorization()
//        locationManager.startMonitoringVisits ()
//        locationManager.delegate = self
//
//
//    }
//
//}

//extension MapVC: CLLocationManagerDelegate {
//  func locationManager(_ manager: CLLocationManager, didVisit visit: CLVisit) {
//    // create CLLocation from the coordinates of CLVisit
//    let clLocation = CLLocation(latitude: visit.coordinate.latitude, longitude: visit.coordinate.longitude)
//
//    MapVC.geoCoder.reverseGeocodeLocation(clLocation) { placemarks, _ in
//      if let place = placemarks?.first {
//        let description = "\(place)"
//        self.newVisitReceived(visit, description: description)
//      }
//    }
//
//  }
//}

