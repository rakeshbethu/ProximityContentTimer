////
////  LoginVC.swift
////  FitnessTrackerAdminApp
////
////  Created by Admin on 8/9/15.
////  Copyright (c) 2015 Techbees. All rights reserved.
////
//
//import UIKit
//
//// This class implements the Login screen
//class LoginVC: UIViewController, UITextFieldDelegate {
//    
//    var appy:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//    var adminCredentials = [String]()
//    
//    @IBOutlet weak var messageLBL: UILabel!
//    @IBOutlet weak var alertMessageLBL: UILabel!
//    @IBOutlet weak var usernameTF: UITextField!
//    @IBOutlet weak var passwordTF: UITextField!
//    
//    
//    // Method invoked when the user clicks on "Login"
//    @IBAction func Login(sender: AnyObject) {
//        
//        // Checking if any textfields were left empty
//        if self.usernameTF.text == "" || self.passwordTF.text == "" {
//            let alert = UIAlertController(title: "", message:"Please enter all the fields", preferredStyle: .Alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
//            self.presentViewController(alert, animated: true){}
//        }
//        else {
//            //var flag:Bool = false
//            self.messageLBL.text = ""
//            
//            let user = PFUser()
//            user.username = self.usernameTF.text
//            user.password = self.passwordTF.text
//            
//            PFUser.logInWithUsernameInBackground(self.usernameTF.text!, password: self.passwordTF.text!, block: { ( user : PFUser?, error : NSError?) -> Void in
//                
//                if error == nil {
//                    if !(user?.valueForKey("emailVerified") as! Bool) {
//                        let alert = UIAlertController(title: "", message:"Your account has not been verified", preferredStyle: .Alert)
//                        alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
//                        self.presentViewController(alert, animated: true){}
//                        PFUser.logOutInBackground()
//                        return
//                    }
//
//                    // If login is successful
//                    dispatch_async(dispatch_get_main_queue()) {
//                        self.appy.username = self.usernameTF.text!
//                        self.alertMessageLBL.text = ""
//                        let tabBarController = self.storyboard?.instantiateViewControllerWithIdentifier("tabBarController") as! UITabBarController
//                        self.presentViewController(tabBarController, animated: true, completion: nil)
//                        
//                    }
//                }
//                // If login failed due to invalid credentials
//                else {
//                    var errorMessage : String =  (error?.localizedDescription)!
//                    errorMessage = errorMessage.stringByReplacingCharactersInRange(errorMessage.startIndex...errorMessage.startIndex, withString: String(errorMessage[errorMessage.startIndex]).uppercaseString)
//                    
//                    if errorMessage == "Invalid login parameters" {
//                        self.alertMessageLBL.text = "Invalid parameters"
//                        self.usernameTF.text = ""
//                        self.passwordTF.text = ""
//                    } else {
//                        let alert = UIAlertController(title: "", message:"\(errorMessage)", preferredStyle: .Alert)
//                        alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
//                        self.presentViewController(alert, animated: true){}
//                    }
//                    dispatch_async(dispatch_get_main_queue()){
//                         self.usernameTF.becomeFirstResponder()
//                    }
//                   
//                }
//                
//            })
//            
//        }
//    }
//    
//    
//    // Method invoked when the user presses on "Create Account"
//    // Invokes CreateAccountVC view controller
//    @IBAction func createAccount(sender: AnyObject) {
//        let createAccountNC = self.storyboard?.instantiateViewControllerWithIdentifier("createAccountNC") as! UINavigationController
//        self.presentViewController(createAccountNC, animated: true, completion: nil)
//    }
//    
//    override func viewDidLoad() {
//        
//        self.navigationController?.navigationBar.barTintColor = UIColor(red: 42/255, green: 82/255, blue: 139/255, alpha: 1)
//        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
//        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
//        
//        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpg")!)
//        
//        self.messageLBL.text = appy.message
//        super.viewDidLoad()
//        
//    }
//    
//    override func viewWillAppear(animated: Bool) {
//        
//        if !Reachability.isConnectedToNetwork() {
//            let alert = UIAlertController(title: "", message:"Make sure your device is connected to the internet.", preferredStyle: .Alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
//            self.presentViewController(alert, animated: true){}
//        }
//        
//        self.alertMessageLBL.text = ""
//        self.messageLBL.text = appy.message
//        self.appy.message = ""
//        self.usernameTF.text = ""
//        self.passwordTF.text = ""
//        super.viewWillAppear(true)
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
//    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        self.view.endEditing(true)
//    }
//    
//}
