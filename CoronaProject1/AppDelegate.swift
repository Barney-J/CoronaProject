import UIKit
import Firebase
import UserNotifications
import Swinject

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let notificationCenter = UNUserNotificationCenter.current()
//    var logger: Logger?
    
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
        let container = Container()
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
        Dependency.container = container
        
//        logger = Logger(eventManager: Dependency.container.resolve(EventManager.self)!)
        
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
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
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

