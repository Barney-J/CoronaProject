import UIKit
import WebKit

class WebViewController: UIViewController , WKUIDelegate{

    var webView: WKWebView!
    
    var url = URL(string: " ")
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = try? URL(resolvingAliasFileAt: url!)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        print("!!!!!!!!!!!!\(myURL)")
    }
}
