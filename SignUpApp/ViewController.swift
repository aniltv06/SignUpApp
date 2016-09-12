//
//  ViewController.swift
//  SignUpApp
//
//  Created by anilkumar thatha. venkatachalapathy on 12/09/16.
//  Copyright © 2016 Anil T V. All rights reserved.
//

import UIKit
import DigitsKit

class ViewController: UIViewController, DGTAuthEventDelegate {

    @IBOutlet weak var signUpButton : UIButton!
    @IBOutlet weak var logOutButton : UIButton!
    var label : UILabel! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Digits.sharedInstance().logOut()
        self.label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 21))
        self.label.font = UIFont.preferredFont(forTextStyle: .footnote)
        self.label.textColor = .black
        self.label.center = CGPoint(x: 200, y: 300)
        self.label.textAlignment = .center
        self.label.text = "Phone Number Verified Successfully"
        self.logOutButton.isHidden = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didTapButton(_ sender: AnyObject) {
        let digits = Digits.sharedInstance()
        digits.authEventDelegate = self
        
        let configuration = DGTAuthenticationConfiguration(accountFields: .defaultOptionMask)
        configuration?.phoneNumber = "+91"
        
        let appearance = DGTAppearance()
        appearance.accentColor = UIColor.black
        appearance.backgroundColor = UIColor.white
        digits.authenticate(with: self, configuration: configuration!)
        {(session, error) -> Void in
            // Inspect session/error objects
            if (session != nil) {
                self.signUpButton.isHidden = true
                self.logOutButton.isHidden = false
                print(session?.phoneNumber)
                print(session?.userID)
                print(session?.authToken)
                print(session?.authTokenSecret)
                self.view.addSubview(self.label)
            }
            else {
                print(error?.localizedDescription)
            }
        }
    }
    
    @IBAction func logOutButtonTapped(_ sender: AnyObject) {
         Digits.sharedInstance().logOut()
        self.signUpButton.isHidden = false
        self.logOutButton.isHidden = true
        self.label.removeFromSuperview()
    }
}

