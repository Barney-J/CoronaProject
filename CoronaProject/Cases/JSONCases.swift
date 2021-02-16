import Foundation
import UIKit
import PKHUD

extension TableCasesVC{
    func jsonCases(){
                let config = URLSessionConfiguration.default
                let session = URLSession(configuration: config)
                guard
                    let url = URL(string:
                    "https://api.apify.com/v2/key-value-stores/tVaYRsPHLjNdNBu7S/records/LATEST?disableRedirect=true")
                else { return }
                let urlRequest = URLRequest(url: url)
                let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
                    guard let data = data else {return}
                    guard error == nil else {return}
                    do{
                        let decoder = JSONDecoder()
                        let countries = try decoder.decode([Country].self, from: data)
                        self.countryManager = countries
                        DispatchQueue.main.async{
                            self.tableView.reloadData()
                            HUD.flash(.success, delay: 1.0)
                        }
                    }catch let error {
                        print(error)
                    }
                }
                dataTask.resume()
    }
}
