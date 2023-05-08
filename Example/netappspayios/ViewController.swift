import UIKit
import netappspayios

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(type: .system)
        button.setTitle("Make Payment", for: .normal)
        button.addTarget(self, action: #selector(InitPayment), for: .touchUpInside)
        view.addSubview(button)
        
        // Position the button in the center of the view
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func InitPayment() {
        let payload = [
              "currency" : "NGN",
              "public_key" : "b1108bfb3e2542b287162ef27da838f9",
              "amount" : "1000",
              "phone" : "09089",
              "tx_ref" : "knjhgjkllhgfhojihugfyhiguf",
              "returnUrl" : "https://www.netapps.ng",
              "paymentChannels" : "card,ussd,trf,paya",
              "email" : "nwokolawrence6@gmail.com",
              "fullname" : "Nwoko Ndubueze",
              "narration" : "Testing"
        ]
        
        presentNetAppsPayActionSheet(withJson: payload, onSuccess: { response in
            print("Payment succeeded with response: \(response)")
        }, onError: {error in
            print("Payment failed: \(error)")
        })
    }
}
