
import UIKit
import Lottie

class LoginViewController: UITableViewController {
   
   @IBOutlet weak var email: UITextField!
   @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var mainTitle: UINavigationItem!
    //navigationController?.navigationBar.prefersLargeTitles = true
    
    //self.mainTitle.textColor = .green
    
    @IBOutlet weak var animationView: LottieAnimationView!
    override func viewDidLoad() {
        self.loadLottieAnimation()
        //let appearance = UINavigationBarAppearance()
        let titleLabel = UILabel()
            titleLabel.text = "GREEN THUMB"
            titleLabel.font = UIFont.systemFont(ofSize: 35.0, weight: .bold) 
            titleLabel.sizeToFit()
        titleLabel.textColor = UIColor(named: "appColor")

            // Assign the label as the title view
            navigationItem.titleView = titleLabel
       // navigationController?.navigationBar.prefersLargeTitles = true
        //navigationItem.title = "GREEN THUMB"
        //navigationItem.titleView?
       // appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "appColor")]
      //  navigationItem.standardAppearance = appearance
        //navigationItem.scrollEdgeAppearance = appearance
        //navigationItem.titleColor = .green
    }
 
   @IBAction func onLogin(_ sender: Any) {
       
       if(email.text!.isEmpty) {
           showAlert(message: "Please enter your email id.")
           return
       }
       
       if(self.password.text!.isEmpty) {
           showAlert(message: "Please enter your password.")
           return
       }
       
       DatabseHelper.shared.login(email: email.text!, password: self.password.text!)
       
   }
   
   
   @IBAction func onLockButtonPressed(_ sender: UIButton) {
       
       self.password.isSecureTextEntry.toggle()
      
       let buttonImageName = password.isSecureTextEntry ? "lock" : "lock.open"
           if let buttonImage = UIImage(systemName: buttonImageName) {
               sender.setImage(buttonImage, for: .normal)
       }
   }
    
    
    func loadLottieAnimation() {
        animationView.animation = LottieAnimation.named("plant")
        animationView.loopMode = .loop
        animationView.contentMode = .scaleAspectFit
        animationView.play()
    }
}





