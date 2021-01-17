import UIKit
import Foundation
import PKHUD

class TableCases: UITableViewController{
    
    var countryManager: [Country] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Cases"
        
        HUD.show(.progress)
        jsonCases()
        HUD.flash(.success, delay: 1.0)
    }
  
//MARK:refreshControl
    @IBAction private func refreshControl(_ sender: UIRefreshControl) {
        jsonCases()
        sender.endRefreshing()
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = false
    }
//MARK: numberOfRowsInSection
    override func tableView(_ tableView: UITableView,
               numberOfRowsInSection section: Int) -> Int {
        return countryManager.count
    
    }
//MARK: cellForRowAt
    override func tableView(_ tableView: UITableView,
                                  cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",
                                                 for: indexPath) as! TableCasesCell

        cell.country.text = countryManager[indexPath.row].country
        cell.infectedInt.text = String(countryManager[indexPath.row].infected ?? 0)
        cell.recoveredInt.text = String(countryManager[indexPath.row].recovered ?? 0)
        
        return cell
    }
//MARK: Prepare For Segue
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            if  let indexPath = self.tableView.indexPathForSelectedRow {
                let infoView = segue.destination as! InfoView
                infoView.infectedInfoView = String(countryManager[indexPath.row].infected ?? 0)
                infoView.recoveredInfoView = String(countryManager[indexPath.row].recovered ?? 0)
                infoView.self.navigationItem.title = countryManager[indexPath.row].country
            }
        }
    }
}
