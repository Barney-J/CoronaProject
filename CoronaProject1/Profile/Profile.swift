import UIKit
import UserNotifications

class Profile: UIViewController {

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    
    var datePicker: Date?
    
    let textField = UITextField()
    let picker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        textField.inputView = picker
//MARK: DataPicker
        picker.datePickerMode = .dateAndTime
        picker.preferredDatePickerStyle = .wheels
//MARK: styling textField
        textField.placeholder = "Reminder"
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = CGFloat(Float(1.0))
        textField.backgroundColor = .gray
        textField.textAlignment = .center
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
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.inputAccessoryView = toolbar
        view.addSubview(textField)

        textField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200).isActive = true
        textField.widthAnchor.constraint(equalToConstant: 250).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        username.text = UserManager.username
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
    }
    
 
//MARK: #selector for toolbar
    @objc func donePressed(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        let stringDate = dateFormatter.string(from: picker.date)
        textField.text = stringDate
        datePicker = picker.date
        sendNotifications()
        self.view.endEditing(true)
    }
 
    
    @objc func cancelPresser(){
        self.view.endEditing(true)
    }
    @objc func clearPressed(){
        self.textField.text = nil
        self.view.endEditing(true)
    }
//MARK: sendNotifications
    func sendNotifications() {
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
    
    
    
//MARK: setVC to LoginView
    @IBAction func goLoginView(_ sender: UIButton) {
        guard let navigationController = self.navigationController else {return}
        
        let login = [LoginView()]
        navigationController.tabBarController?.navigationController?.setViewControllers(login, animated: true)
    }
    

}
