//
//  SignUpVC.swift
//  ProximityContent
//
//  Created by Rakesh Bethu on 10/11/16.
//  Copyright © 2016 Estimote, Inc. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

class SignUpVC: UIViewController {
    
    @IBOutlet var passwordTF: UITextField!
    @IBOutlet var usernameTF: UITextField!
    @IBOutlet var confirmPasswordTF: UITextField!
    @IBOutlet var emailTF: UITextField!
    let publicDatabase = CKContainer.defaultContainer().publicCloudDatabase
    func validateEmail(candidate: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluateWithObject(candidate)
    }
    
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var passwordLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    
    @IBAction func SignUp(sender: UIButton) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "signUp", predicate: predicate)
        var record:CKRecord = CKRecord(recordType: "signUp")
        
        
        publicDatabase.performQuery(query, inZoneWithID: nil) { (records, error) in
            if(error == nil){
                var count = 0
                for record in records!{
                    if(record["email"] as? String == self.emailTF.text){
                        count += 1
                    }
                }
                if count > 0 {
                    self.emailLabel.text = "Email ID already exists"
                    self.emailTF.text = ""
                } else if !self.validateEmail(self.emailTF.text!) {
                    self.emailLabel.text = "Invalid email address"
                } else {
                    //check for usernames
                    var count2 = 0
                    for record in records!{
                        if(record["email"] as? String == self.emailTF.text){
                            count2 += 1
                        }
                    }
                    if count2 > 0 {
                        self.emailLabel.text = "Username already exists"
                        self.emailTF.text = ""
                    } else if !self.validateEmail(self.emailTF.text!) {
                        self.emailLabel.text = "Invalid Username"
                    }else{
                        
                        //If both the entered passwords match
                        if(self.passwordTF.text == self.confirmPasswordTF.text!){
                            // self.appy.message = "Account created successfully :)"
                            let recordType = CKRecord(recordType: "signUp")
                            
                            recordType["username"] = self.usernameTF.text
                            recordType["password"] = self.passwordTF.text
                            recordType["email"] = self.emailTF.text
                            
                            self.publicDatabase.saveRecord(recordType) { (record, error) in
                                if(error == nil){
                                    print("User Saved")
                                } else{
                                    print(error?.localizedDescription)
                                }
                            }
                            
                        }else{
                            self.emailLabel.text = "Password mismatch"
                            self.confirmPasswordTF.text = ""
                        }
                    }
                }
                
                //
            }else{
                print(error?.localizedDescription)
            }
        }
        
        
        
        
        
        let recordType = CKRecord(recordType: "signUp")
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}