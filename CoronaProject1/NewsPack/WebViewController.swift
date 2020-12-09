import UIKit
import WebKit

class WebViewController: UIViewController , WKUIDelegate{

    var webView: WKWebView!
    
    var url: URL?
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        let myURL = try? URL(resolvingAliasFileAt: url!)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
}
