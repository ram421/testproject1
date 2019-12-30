//  ViewController.swift
//  FitQ
//  Created by vishnu.kumar on 11/12/19.
//  Copyright © 2019 appmantras. All rights reserved.


import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn


class LoginViewController: UIViewController,GIDSignInDelegate,GIDSignInUIDelegate {
    var dict : [String : AnyObject]!
    @IBOutlet weak var Signupview: UIView!
    @IBOutlet weak var Google: GIDSignInButton!
    @IBOutlet weak var Loginview: UIView!
    @IBOutlet weak var Signuppassword: UITextField!
    @IBOutlet weak var Signup: UIButton!
    @IBOutlet weak var Facebook: UIButton!
    @IBOutlet weak var Passwordtextfield: UITextField!
    @IBOutlet weak var Signupusername: UITextField!
    @IBOutlet weak var Usernametextfield: UITextField!
    @IBOutlet weak var Switchbutton: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        Switchbutton.selectedSegmentIndex = 0
        Signupview.isHidden = true
        Switchbutton.apportionsSegmentWidthsByContent = true
        Switchbutton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline)], for: .selected)
        Switchbutton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline)], for: .highlighted)
        Switchbutton.layer.cornerRadius = Switchbutton.bounds.height/2
        Switchbutton.layer.borderColor = UIColor.white.cgColor
        Switchbutton.layer.borderWidth = 1.0
        Switchbutton.layer.masksToBounds = true
        
        
        drawline(textfield: Usernametextfield)
        drawline(textfield: Passwordtextfield)
        drawline(textfield: Signupusername)
        drawline(textfield: Signuppassword)

        Usernametextfield.attributedPlaceholder = NSAttributedString(string: "Enter Email/Mobile No.",attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        Passwordtextfield.attributedPlaceholder = NSAttributedString(string: "Enter Password",attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        Signupusername.attributedPlaceholder = NSAttributedString(string: "Enter Email/Mobile No.",attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        Signuppassword.attributedPlaceholder = NSAttributedString(string: "Enter Password",attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        Switchbutton.addTarget(self, action: #selector(mapTypeChanged), for: .valueChanged)

    }
    
    func drawline(textfield:UITextField) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: textfield.bounds.origin.x, y: textfield.frame.height-1, width: textfield.bounds.width, height: 1)
        bottomLine.backgroundColor = UIColor.black.cgColor
        textfield.borderStyle = UITextField.BorderStyle.none
        textfield.layer.addSublayer(bottomLine)
    }
    
    @objc func mapTypeChanged(segControl: UISegmentedControl) {
        if (segControl.selectedSegmentIndex == 0 ) {
            Signupview.isHidden = true
            Loginview.isHidden = false
            }
        else{
            Signupview.isHidden = false
            Loginview.isHidden = true
        }
        }
    @IBAction func Googlelogin(_ sender: Any) {
        
        GIDSignIn.sharedInstance().delegate=self
        GIDSignIn.sharedInstance().uiDelegate = self
//        GIDSignIn.sharedInstance().uiDelegate=self as! GIDSignInUIDelegate
        GIDSignIn.sharedInstance().signIn()
        
        
        
    }
    
    //MARK:Google SignIn Delegate
    
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
    }
    // Present a view that prompts the user to sign in with Google
    
    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    // Dismiss the "Sign in with Google" view
    
    func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    //completed sign In
    
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
                       withError error: Error!) {
        if (error == nil) {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            
            // ...
        } else {
            print("\(error.localizedDescription)")
        }
    }

    @IBAction func Facebooklogin(_ sender: Any) {
        getFBUserData()
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email"], handler: { (result, error) -> Void in
            
            print("\n\n result: \(result)")
            print("\n\n Error: \(error)")
            
           
            
            if (error == nil) {
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                if(fbloginresult.isCancelled) {
                    //Show Cancel alert
                } else if(fbloginresult.grantedPermissions.contains("email")) {
                    
                    print("granntede")
//                    self.returnUserData()
                    //fbLoginManager.logOut()
                }
            }
        })
        
        
        
    }
    
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    self.dict = result as! [String : AnyObject]
                    print(result!)
                    print(self.dict)
                }
            })
        }
    }
}


extension UITextField {
    func setIcon(_ image: UIImage) {
        let iconView = UIImageView(frame:
            CGRect(x: 10, y: 5, width: 20, height: 20))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame:
            CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
}


