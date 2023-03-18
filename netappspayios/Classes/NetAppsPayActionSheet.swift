import UIKit
import WebKit
import FLAnimatedImage

class NetAppsPayActionSheet: UIViewController, WKNavigationDelegate, WKScriptMessageHandler {
    
    private let url: URL
    private var onSuccessCallback: ((_ res:String) -> Void)?
    private var onErrorCallback: ((_ res:String) -> Void)?
    
    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.backgroundColor = .clear
        webView.isOpaque = false
        return webView
    }()
    
    private let loadingImageView: FLAnimatedImageView = {
        let loadingImageView = FLAnimatedImageView()
        loadingImageView.translatesAutoresizingMaskIntoConstraints = false
        loadingImageView.contentMode = .scaleAspectFit
        loadingImageView.isHidden = true
        return loadingImageView
    }()
    
    public init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .formSheet
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setSuccessCallback(_ callback: ((_ res: String) -> Void)?) {
        self.onSuccessCallback = callback
    }
    
    public func setErrorCallback(_ callback: ((_ res:String) -> Void)?) {
        self.onErrorCallback = callback
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(webView)
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        let queue = DispatchQueue.global(qos: .userInitiated)
        queue.async {
            if let imageData = try? Data(contentsOf: URL(string: Constants.loaderImage)!) {
                DispatchQueue.main.async {
                    let loadingImage = FLAnimatedImage(animatedGIFData: imageData)
                    self.loadingImageView.animatedImage = loadingImage
                }
            }
        }
    

        
        view.addSubview(loadingImageView)
        
        NSLayoutConstraint.activate([
            loadingImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingImageView.widthAnchor.constraint(equalToConstant: 200),
            loadingImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        webView.configuration.userContentController.add(self, name: "WebEvent")
        webView.configuration.preferences.javaScriptEnabled = true
        webView.navigationDelegate = self
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        loadingImageView.isHidden = false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingImageView.isHidden = true
    }
    
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        loadingImageView.isHidden = true
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    public func close() {
           dismiss(animated: true, completion: nil)
       }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        // Check if the URL contains the specific pattern
        if let url = navigationAction.request.url,
           let _ = url.absoluteString.lowercased().range(of: "https://cipa.unifiedpaymentsnigeria.com/result") {
            
            // Open the URL in a new tab
            let newWebView = WKWebView(frame: webView.bounds, configuration: webView.configuration)
            newWebView.navigationDelegate = self
            let newViewController = UIViewController()
            newViewController.view.addSubview(newWebView)
            newWebView.frame = newViewController.view.bounds
            
            // Attempt to load the URL request in the new web view
            newWebView.load(navigationAction.request)
            
            // If the new web view was able to load the URL request, do not cancel the navigation
            if let _ = newWebView.url {
                navigationController?.pushViewController(newViewController, animated: true)
                decisionHandler(.cancel)
                return
            }
        }
        
        // Allow the navigation to proceed in the current web view
        decisionHandler(.allow)
    }


    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            guard let body = message.body as? [String: Any] else {
                return
            }
            if let message = body["message"] as? String {
                if message.contains("SUCCESS") {
                    onSuccessCallback?(message)
                    return
                }
                if message.contains("FAILED") {
                    onErrorCallback?(message)
                    return
                }
                if message.contains("close") {
                    close()
                    return
                }
            }
        }
    }

extension UIViewController {
    public func presentNetAppsPayActionSheet(withJson json: [String: Any], onSuccess: ((String) -> Void)? = nil, onError: ((String) -> Void)? = nil) {
        let baseUrl = "https://cdn.netapps.ng/"
        let queryItems = json.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        var urlComponents = URLComponents(string: baseUrl)
        urlComponents?.queryItems = queryItems
        guard let url = urlComponents?.url else {
            print("base Error: \(baseUrl)\(queryItems)")
            onError?("SDK Error")
            return
        }

           
           let netAppsPayActionSheet = NetAppsPayActionSheet(url: url)
           netAppsPayActionSheet.setSuccessCallback(onSuccess)
           netAppsPayActionSheet.setErrorCallback(onError)
           let popoverPresentationController = netAppsPayActionSheet.popoverPresentationController
           popoverPresentationController?.sourceView = self.view
           popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
           popoverPresentationController?.permittedArrowDirections = [.down]
           present(netAppsPayActionSheet, animated: true, completion: nil)
       }
}
