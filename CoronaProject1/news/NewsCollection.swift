import UIKit

private let reuseIdentifier = "Cell"

class NewsCollection: UICollectionViewController {
    
    let articles = Article.getTitle()
    let author = Article.getAuthor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "News"
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath) as! CollectionViewCell
    
        cell.titleCell.text = articles[indexPath.row].title
        cell.authorCell.text = author[indexPath.row].author
        
        return cell
    }


}
