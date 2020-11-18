import UIKit
import Foundation

private let reuseIdentifier = "Cell"

class NewsCollection: UICollectionViewController {
    
    private var articleManager: Article = Article()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "News"
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=b305eaf8510c46a1918d14121688b90f&category=health"
        )else { return }
        
        let urlRequest = URLRequest(url: url)

        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let error = error{
                print(error)
            }
            
            if let data = data {
                
                let decoder = JSONDecoder()
                let article = try? decoder.decode(Article.self, from: data)
                
                print([article])

                DispatchQueue.main.async{
                    guard let article = article else {return}
                    self.articleManager = article
                    self.collectionView.reloadData()
                }
            }
        }
        dataTask.resume()
        
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4 //articleManager.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath) as! CollectionViewCell
    
        //cell.titleCell.text = articleManager[indexPath.row].title
        //cell.authorCell.text = articleManager[indexPath.row].author
        
        return cell
    }


}
