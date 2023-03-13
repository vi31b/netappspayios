## Installation

netappspayios is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'netappspayios'
```

### NetAppsPay Integration
NetAppsPay is a payment processing platform that allows you to easily integrate payments into your iOS application. In this guide, we will show you how to integrate NetAppsPay using the netappspayios library.

### Getting Started
To use NetAppsPay, you will need a NetAppsPay public key. You can obtain this by signing up for a NetAppsPay account and creating an application.

Steps
* Import the netappspayios library into your project.

```swift
import netappspayios
```

* In your view controller, define a function to show the NetAppsPay action sheet when a button is clicked.

```swift
@objc func showNetAppsPayActionSheet() {
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
    }, onError: { error in
        print("Payment failed: \(error)")
        let alert = UIAlertController(title: "Payment Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    })
}
```
* Create a button in your view controller to trigger the showNetAppsPayActionSheet function when clicked.
```swift
let button = UIButton(type: .system)
button.setTitle("Pay with NetAppsPay", for: .normal)
button.addTarget(self, action: #selector(showNetAppsPayActionSheet), for: .touchUpInside)
view.addSubview(button)

// Position the button in the center of the view
button.translatesAutoresizingMaskIntoConstraints = false
NSLayoutConstraint.activate([
    button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
])
```


That's it! When the button is clicked, the showNetAppsPayActionSheet function will be called, which will initiate the payment process using the NetAppsPay iOS library. You can add additional code in the callback function to handle the success or failure of the payment, and display error messages more gracefully to the user.


