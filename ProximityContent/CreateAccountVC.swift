////
////  CreateAccountVC.swift
////  FitnessTrackerAdminApp
////
////  Created by Admin on 8/9/15.
////  Copyright (c) 2015 Techbees. All rights reserved.
////
//
//import UIKit
//import CloudKit
//
//// This class represents the Create Account screen
//class CreateAccountVC: UIViewController, UITextFieldDelegate {
//    
//    var appy:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//    
//    @IBOutlet weak var usernameMsgLBL: UILabel!
//    @IBOutlet weak var emailMsgLBL: UILabel!
//    
//    @IBAction func cancel(sender: AnyObject) {
//        self.dismissViewControllerAnimated(true, completion: nil)
//    }
//    @IBAction func usernameTFACN(sender: AnyObject) {
//        if self.usernameMsgLBL.text == "Username already exists" {
//            self.usernameMsgLBL.text = ""
//        }
//        else if self.usernameTF.text?.characters.count >= 6 {
//            self.usernameMsgLBL.text = ""
//        }
//        
//    }
//    @IBAction func emailTFACN(sender: AnyObject) {
//        if self.emailMsgLBL.text == "Email ID already exists" {
//            self.emailMsgLBL.text = ""
//        }
//    }
//    
//    @IBAction func confirmPasswordTFACN(sender: AnyObject) {
//        if self.alertMessageLBL.text == "Password mismatch" {
//            self.alertMessageLBL.text = ""
//        }
//    }
//    
//    
//    @IBAction func emailAddressTFACN(sender: AnyObject) {
//        self.emailMsgLBL.text = ""
//    }
//    
//    @IBOutlet weak var alertMessageLBL: UILabel!
//    @IBOutlet weak var usernameTF: UITextField!
//    @IBOutlet weak var passwordTF: UITextField!
//    @IBOutlet weak var confirmPasswordTF: UITextField!
//    @IBOutlet weak var emailTF: UITextField!
//    let publicDatabase = CKContainer.defaultContainer().publicCloudDatabase
//    func validateEmail(candidate: String) -> Bool {
//        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
//        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluateWithObject(candidate)
//    }
//    // Method invoked when the user click on "Create Account"
//    @IBAction func create(sender: AnyObject) {
//        
//        // Checking if any textfields were left empty
//        if self.usernameTF.text == "" || self.passwordTF.text == "" || self.confirmPasswordTF.text == "" || self.emailTF.text == "" {
//            let alert = UIAlertController(title: "", message:"Please enter all the fields", preferredStyle: .Alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
//            self.presentViewController(alert, animated: true){}
//        }
//        else {
//          
//            //connecting to cloudKit
//            let predicate = NSPredicate(value: true)
//            let query = CKQuery(recordType: "Users", predicate: predicate)
//            var record:CKRecord = CKRecord(recordType: "Users")
//         
//            
//            publicDatabase.performQuery(query, inZoneWithID: nil) { (records, error) in
//                if(error == nil){
//                    var count = 0
//                    for record in records!{
//                        if(record["email"] as? String == self.emailTF.text){
//                            count += 1
//                        }
//                    }
//                    if count > 0 {
//                        self.emailMsgLBL.text = "Email ID already exists"
//                        self.emailTF.text = ""
//                    } else if !self.validateEmail(self.emailTF.text!) {
//                        self.emailMsgLBL.text = "Invalid email address"
//                    } else {
//                        
//                        //If both the entered passwords match
//                        if(self.passwordTF.text == self.confirmPasswordTF.text!){
//                            self.appy.message = "Account created successfully :)"
//                            let recordType = CKRecord(recordType: "Users")
//                            
//                            recordType["username"] = self.usernameTF.text
//                            recordType["password"] = self.passwordTF.text
//                            recordType["email"] = self.emailTF.text
//                            
//                            self.publicDatabase.saveRecord(recordType) { (record, error) in
//                                if(error == nil){
//                                    print("User Saved")
//                                } else{
//                                    print(error?.localizedDescription)
//                                }
//                            }
//
//                        }else{
//                            self.alertMessageLBL.text = "Password mismatch"
//                            self.confirmPasswordTF.text = ""
//                        }
//                    }
//                    
// //
//                }else{
//                    print(error?.localizedDescription)
//                }
//            }
//        //
//    
//    // Method invoked if the user presses "Cancel" button
//   
//    func viewDidLoad() {
//        
//        self.navigationController?.navigationBar.barTintColor = UIColor(red: 42/255, green: 82/255, blue: 139/255, alpha: 1)
//        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
//        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
//        
//        
//        self.usernameMsgLBL.text = ""
//        self.emailMsgLBL.text = ""
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//    }
//    
//    func viewWillAppear(animated: Bool) {
//        self.alertMessageLBL.text = ""
//        self.usernameTF.text = ""
//        self.passwordTF.text = ""
//        self.confirmPasswordTF.text = ""
//        super.viewWillAppear(true)
//    }
//    
// 
//    
//    func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
//    
//    
//    
//    // Validating username
////    func textFieldDidEndEditing(textField: UITextField) {
////        if textField == self.usernameTF {
////            let query = PFQuery(className: "_User")
////            query.whereKey("username", equalTo: self.usernameTF.text!)
////            query.countObjectsInBackgroundWithBlock { (count: Int32, error:NSError?) -> Void in
////                if error == nil {
////                    if self.usernameTF.text?.characters.count < 6 {
////                        self.usernameMsgLBL.text = "Username must have at least 6 characters"
////                        self.usernameTF.becomeFirstResponder()
////                    }
////                    else if count > 0 {
////                        self.usernameMsgLBL.text = "Username already exists"
////                        self.usernameTF.text = ""
////                        self.usernameTF.becomeFirstResponder()
////                    }
////                }
////                
////            }
////        }
////            
////        else if textField == self.confirmPasswordTF {
////            if self.passwordTF.text != self.confirmPasswordTF.text {
////                self.alertMessageLBL.text = "Password mismatch"
////                self.confirmPasswordTF.text = ""
////            }
////        }
////        else if textField == self.emailTF {
////            let query = PFQuery(className: "_User")
////            query.whereKey("email", equalTo: self.emailTF.text!)
////            query.countObjectsInBackgroundWithBlock { (count: Int32, error:NSError?) -> Void in
////                if error == nil {
////                    if count > 0 {
////                        self.emailMsgLBL.text = "Email ID already exists"
////                        self.emailTF.text = ""
////                    }
////                    
////                }
////                
////            }
////        }
////    
////    }
//    
//    func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        self.view.endEditing(true)
//    }
//}
//
//
