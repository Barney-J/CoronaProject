import UIKit

class InfoView: UIViewController {

    @IBOutlet weak var infectedLabel: UILabel!
    @IBOutlet weak var recoveredLabel: UILabel!
    
    var infectedInfoView = ""
    var recoveredInfoView = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        infectedLabel.text = String(infectedInfoView)
        recoveredLabel.text = String(recoveredInfoView)
    }
    

}
