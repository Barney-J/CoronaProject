import UIKit
import Foundation

class TableCases: UITableViewController{
    
    private var countryManager: [Country] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Cases"
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        guard let url = URL(string: "https://api.apify.com/v2/key-value-stores/tVaYRsPHLjNdNBu7S/records/LATEST?disableRedirect=true"
        )else { return }
        
        let urlRequest = URLRequest(url: url)

        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let data = data {
                
                let decoder = JSONDecoder()
                let countries = try? decoder.decode([Country].self, from: data)
                
                DispatchQueue.main.async{
                    guard let countries = countries else {return}
                    self.countryManager = countries
                    self.tableView.reloadData()
                }

            }
        }
            dataTask.resume()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func tableView(_ tableView: UITableView,
               numberOfRowsInSection section: Int) -> Int {
        
        return countryManager.count
    
    }
    
    override func tableView(_ tableView: UITableView,
                                  cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",
                                                 for: indexPath) as! TableCasesCell
        
        cell.country.text = countryManager[indexPath.row].country
        cell.infectedInt.text = String(countryManager[indexPath.row].infected!)
        cell.recoveredInt.text = String(countryManager[indexPath.row].recovered ?? 0)
        return cell
    }

        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            if  let indexPath = self.tableView.indexPathForSelectedRow {
                let infoView = segue.destination as! InfoView
                infoView.infectedInfoView = String(countryManager[indexPath.row].infected!)
                infoView.recoveredInfoView = String(countryManager[indexPath.row].recovered ?? 0)
                infoView.self.navigationItem.title = countryManager[indexPath.row].country
            }
        }
    }
}
