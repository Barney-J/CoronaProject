import UIKit
import Firebase
import UserNotifications
import Swinject

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let notificationCenter = UNUserNotificationCenter.current()
    var logger: Logger?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    //MARK: NotificationCenter
        notificationCenter.requestAuthorization(options: [.alert,.sound]) { (granted, error) in
            guard granted else {return}
            self.notificationCenter.getNotificationSettings { (settings) in
                guard settings.authorizationStatus == .authorized else {return}
            }
        }
        notificationCenter.delegate = self
        sendNotifications()
        Dependecies.container = Container()
        Dependecies.registerDependecies()
        logger = Logger(eventManager: Dependecies.container.resolve(EventManager.self)!)
        
        FirebaseApp.configure()

        return true
    }
    func sendNotifications() {
        let content = UNMutableNotificationContent()
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 61,
                                                        repeats: true)
        content.title = "Check new News"
        content.body = "NEW NEWS!!!"
        content.sound = UNNotificationSound.default
        let request = UNNotificationRequest(identifier: "notification",
                                           content: content,
                                           trigger: trigger)
        notificationCenter.add(request)
    }
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}

//MARK:UNUserNotificationCenterDelegate
extension AppDelegate: UNUserNotificationCenterDelegate{
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge,.banner, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(#function)
    }
}

