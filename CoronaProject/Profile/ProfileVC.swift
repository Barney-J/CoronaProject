import UIKit
import UserNotifications

class ProfileVC: UIViewController {

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
//    let containerEventManager = Dependency.container.resolve(EventManager.self)
    
    private var datePicker: Date?
    
    private let textField = UITextField()
    private let picker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.textField.inputView = self.picker
//MARK: DataPicker
        self.picker.datePickerMode = .dateAndTime
        self.picker.preferredDatePickerStyle = .wheels
//MARK: styling textField
        self.textField.placeholder = "Reminder"
        self.textField.layer.cornerRadius = 10
        self.textField.layer.borderWidth = CGFloat(Float(1.0))
        self.textField.backgroundColor = .gray
        self.textField.textAlignment = .center
//MARK: toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .done,
                                         target: self,
                                         action: #selector(donePressed))
        let cancelButton = UIBarButtonItem(title: "Cancel",
                                         style: .done,
                                         target: self,
                                         action: #selector(cancelPresser))
        let clearButton = UIBarButtonItem(title: "Clear",
                                         style: .done,
                                         target: self,
                                         action: #selector(clearPressed))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                    target: nil,
                                    action: nil)

        toolbar.setItems([doneButton,space,cancelButton,clearButton], animated: false)
//MARK:textField  constraint
        self.textField.translatesAutoresizingMaskIntoConstraints = false
        self.textField.inputAccessoryView = toolbar
        view.addSubview(textField)

        self.textField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        self.textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200).isActive = true
        self.textField.widthAnchor.constraint(equalToConstant: 250).isActive = true
        self.textField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        self.username.text = UserManager.username
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
    }
    
 
//MARK: #selector for toolbar
    @objc private func donePressed(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        let stringDate = dateFormatter.string(from: picker.date)
        textField.text = stringDate
        datePicker = picker.date
        sendNotifications()
        self.view.endEditing(true)
    }
 
    
    @objc private func cancelPresser(){
        self.view.endEditing(true)
    }
    @objc private func clearPressed(){
        self.textField.text = nil
        self.view.endEditing(true)
    }
//MARK: sendNotifications
    private func sendNotifications() {
        var dateComponents = DateComponents()
        guard let datePicker = datePicker else {return}
        
        let content = UNMutableNotificationContent()
        content.title = "Read News"
        content.body = "News"
        content.sound = UNNotificationSound.default
        
        let components = Calendar.current.dateComponents([.year,
                                                          .month,
                                                          .day,
                                                          .hour,
                                                          .minute], from: datePicker)
        dateComponents.calendar = Calendar.current
        dateComponents.year = components.year
        dateComponents.month = components.month
        dateComponents.day = components.day
        dateComponents.hour = components.hour
        dateComponents.minute = components.minute
        
       
        let trigger = UNCalendarNotificationTrigger(
                 dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "notification",
                    content: content, trigger: trigger)

        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request)
    }
    
    
    
//MARK: setVC to LoginVC
    @IBAction func goLoginVC(_ sender: UIButton) {
        guard let navigationController = self.navigationController else {return}
        
        let login = [LoginVC()]
        navigationController.tabBarController?.navigationController?.setViewControllers(login, animated: true)
//        self.containerEventManager?.notify()
    }
    

}
