import UIKit
import Foundation
import PKHUD

private let reuseIdentifier = "Cell"

class NewsCollectionVC: UICollectionViewController {
    
    private var queue: OperationQueue?
    var articleManager: News?
    
//MARK: RefreshControl
    private let myRefreshControl: UIRefreshControl = {
       let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "News"
        
        HUD.show(.progress)
        jsonArticle()
        HUD.flash(.success, delay: 1.0)
        collectionView.refreshControl = myRefreshControl
    }

//MARK:shareWithFriends
    
    @IBAction private func openInstagramm(_ sender: UIBarButtonItem) {
        let url = URL(string: "instagram://user?username=barney_jackson")!
        if UIApplication.shared.canOpenURL(url){
                UIApplication.shared.open(url)
        }else{
            let urlApp = URL(string: "https://www.instagram.com/barney_jackson")!
            UIApplication.shared.open(urlApp)
        }
    }
    
    @IBAction private func shareWithFriends(_ sender: UIBarButtonItem) {
        let url = URL(string: "myApplicationCorona://")
        let text = "take a look at the app - \(url!)"
        
        let activityViewController = UIActivityViewController(activityItems:[text],applicationActivities:nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        present(activityViewController,animated: true,completion: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = false
    }
    
//MARK:collectionViewReload
    @objc private func refresh(sender: UIRefreshControl){
        jsonArticle()
        myRefreshControl.endRefreshing()
    }

//MARK:numberOfItemsInSection
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let articleManager = articleManager else {return 0}
        return articleManager.articles.count
    }
//MARK: cellForItemAt
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath) as! CollectionViewCell
        guard let articleManager = articleManager else {return cell}
 
        cell.titleCell.text = articleManager.articles[indexPath.row].title
        cell.titleCell.textColor = .red
        cell.authorCell.text = articleManager.articles[indexPath.row].author
        cell.authorCell.textColor = .red
//MARK: BlockOperation
        let mainQueue = DispatchQueue.main
        queue = OperationQueue()
        queue?.maxConcurrentOperationCount = 1
        let operation = BlockOperation{
            let backgroungImageCell = articleManager.articles[indexPath.row].urlToImage
            let url = URL(string: backgroungImageCell!)
                if let data = try? Data(contentsOf: url!)
                {
                    mainQueue.async {
                        cell.imageBackgroung.image = UIImage(data: data)
                    }
                }
        }
        queue?.addOperation(operation)
        
        cell.publishedCell.textColor = .red
//MARK: DateFormatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let string = articleManager.articles[indexPath.row].publishedAt
        let dataDate  = dateFormatter.date(from: string)
        
        let prettyDateFormatter = DateFormatter()
        prettyDateFormatter.dateStyle = .short
        prettyDateFormatter.timeStyle = .short
        if let dataDate = dataDate{
            let stringDate = prettyDateFormatter.string(from: dataDate)
            cell.publishedCell.text = stringDate
        }
        return cell
    }
//MARK: PrepareForSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Web" {
            let webView: WebViewController = segue.destination as! WebViewController
                let cell = sender as! CollectionViewCell
            
            guard let articleManager = articleManager else {return}
            
            guard let indexPath = self.collectionView!.indexPath(for: cell) else {return}
            guard let articleManagerWithURL = articleManager.articles[indexPath.row].url else {return}
            let url = URL(string: articleManagerWithURL)
            
            webView.url = url
        }
    }
}
