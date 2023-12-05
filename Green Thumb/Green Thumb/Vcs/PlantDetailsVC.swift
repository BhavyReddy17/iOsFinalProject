import UIKit
import WebKit

class PlantDetailsVC: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var plantImage: UIImageView!
    @IBOutlet weak var plantTitle: UILabel!
    @IBOutlet weak var plantDetails: UITextView!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var image: UIImage? = nil
    var identifiedPlant = ""
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the image and title
        self.plantImage.image = image
        self.plantTitle.text = identifiedPlant.capitalized
        
        // Set the WKWebView delegate to self
        webView.navigationDelegate = self
        
        // Start the activity indicator
        activityIndicator.startAnimating()
        
        let urlToLoad = "https://en.wikipedia.org/wiki/\(self.identifiedPlant)".encodedURL().toURL()
        // Load the URL in the WKWebView
        if let url = urlToLoad {
            let request = URLRequest(url: url)
            webView.load(request)
           // navigationController?.setNavigationBarHidden(true, animated: false)
        }
    }

    func removeTopBar() {
            let jsCode = """
                var topBar = document.getElementById('your-top-bar-id'); // Replace 'your-top-bar-id' with the actual ID of the top bar element
                if (topBar) {
                    topBar.remove();
                }
            """
            webView.evaluateJavaScript(jsCode) { (_, error) in
                if let error = error {
                    print("Error injecting JavaScript: \(error.localizedDescription)")
                }
            }
       }
    
    // Decide whether to allow or cancel a navigation
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        // Disable user interaction for links
        if navigationAction.navigationType == .linkActivated {
            decisionHandler(.cancel)
            return
        }
        
        decisionHandler(.allow)
    }
    
    // MARK: - WKNavigationDelegate
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // Stop the activity indicator when the page finishes loading
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        removeTopBar()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("Web view failed to load with error: \(error.localizedDescription)")
        
        // Stop the activity indicator in case of an error
        activityIndicator.stopAnimating()
    }

    @IBAction func onSave(_ sender: Any) {
        DatabseHelper.shared.savePlant(plantName: self.identifiedPlant.capitalized, image: convertImageToBase64String(img: self.image!))
    }
    
    @IBAction func onAddReminder(_ sender: Any) {
       
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddReminderVC") as! AddReminderVC
        vc.identifiedPlant = identifiedPlant
        vc.image = image
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
