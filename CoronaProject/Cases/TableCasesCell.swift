import UIKit

class TableCasesCell: UITableViewCell {
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var infectedInt: UILabel!
    @IBOutlet weak var recoveredInt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
