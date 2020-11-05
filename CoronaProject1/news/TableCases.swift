import UIKit

class TableCases: UITableViewController {
    
    let countryList = [
        "Belarus",
        "Usa",
        "Germany"
    ]
    
    let deathMass = Latest.getDeath()
    let confirmedMass = Latest.getConfirmed()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Cases"

    }

 

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return countryList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",
                                                 for: indexPath) as! TableCasesCell

        cell.country.text = countryList[indexPath.row]
        cell.deathInt.text = String(deathMass[indexPath.row].deaths)
        cell.confirmedInt.text = String(confirmedMass[indexPath.row].confirmed)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            if  let indexPath = self.tableView.indexPathForSelectedRow {
                let infoView = segue.destination as! InfoView
                infoView.confirmedForLabel = confirmedMass[indexPath.row].confirmed
                infoView.deathForLabel = deathMass[indexPath.row].deaths
                infoView.self.navigationItem.title = countryList[indexPath.row]
            }
        }
    }
    

}
