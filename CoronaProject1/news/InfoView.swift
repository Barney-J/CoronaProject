import UIKit

class InfoView: UIViewController {

    @IBOutlet weak var confirmedLabel: UILabel!
    @IBOutlet weak var deathLabel: UILabel!
    
    var confirmedForLabel = 0
    var deathForLabel = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        confirmedLabel.text = String(confirmedForLabel)
        deathLabel.text = String(deathForLabel)

    }
    

}
