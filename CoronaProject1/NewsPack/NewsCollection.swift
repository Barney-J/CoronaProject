import UIKit
import Foundation
import PKHUD

private let reuseIdentifier = "Cell"

class NewsCollection: UICollectionViewController {
    
    private var articleManager: News?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "News"
        HUD.show(.progress)
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=b305eaf8510c46a1918d14121688b90f&category=health"
        )else { return }
        
        let urlRequest = URLRequest(url: url)

        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            
            guard let data = data else {return}
            guard error == nil else {return}
            
            do{
                let decoder = JSONDecoder()
                let newsCollection = try decoder.decode(News.self, from: data)
                dump(newsCollection)
                DispatchQueue.main.async{
                    self.articleManager = newsCollection
                    self.collectionView.reloadData()
                    HUD.flash(.success, delay: 1.0)
                }
            }catch let error {
                print(error)
            }
           
        }
        dataTask.resume()
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let articleManager = articleManager else {return 0}
        return articleManager.articles.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath) as! CollectionViewCell
        guard let articleManager = articleManager else {return cell}
 
        cell.titleCell.text = articleManager.articles[indexPath.row].title
        cell.titleCell.textColor = .red
        cell.authorCell.text = articleManager.articles[indexPath.row].author
        cell.authorCell.textColor = .red
        
        
        let backgroungImageCell = articleManager.articles[indexPath.row].urlToImage
        guard let backgroungImage = backgroungImageCell else {return cell}
        let url = URL(string: backgroungImage)
            if let data = try? Data(contentsOf: url!)
            {
                cell.imageBackgroung.sizeToFit()
                cell.imageBackgroung.contentMode = .scaleToFill
                cell.imageBackgroung.image = UIImage(data: data)
            }
        return cell
    }


}
