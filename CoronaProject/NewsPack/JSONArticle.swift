import Foundation
import UIKit
import PKHUD

extension NewsCollectionVC{
    func jsonArticle(){
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        guard
            let url = URL(string:
            "http://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=b305eaf8510c46a1918d14121688b90f")
        else { return }
        let urlRequest = URLRequest(url: url)
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else {return}
            guard error == nil else {return}
            do{
                let decoder = JSONDecoder()
                let newsCollectionVC = try decoder.decode(News.self, from: data)
                self.articleManager = newsCollectionVC
                DispatchQueue.main.async{
                    self.collectionView.reloadData()
                    HUD.flash(.success, delay: 1.0)
                }
            }catch let error {
                print(error)
            }
        }
        dataTask.resume()
    }
}
