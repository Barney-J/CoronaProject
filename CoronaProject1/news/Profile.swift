import UIKit

class Profile: UIViewController {

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
    }
    @IBAction func goLoginView(_ sender: UIButton) {
        let login = [LoginView()]
        navigationController?.navigationController?.setViewControllers(login, animated: true)
    }
    

}
