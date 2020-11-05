import UIKit

class Profile: UIViewController {

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        username.text = UserManager.userLogin
        
    }
    @IBAction func goLoginView(_ sender: UIButton) {
        
        guard let navigationController = self.navigationController else {return}
        
        let login = [LoginView()]
        navigationController.tabBarController?.setViewControllers(login, animated: true)
    }
    

}
