//
//  LoginViewController.swift
//  ChatLab
//
//  Created by Gina Ratto on 2/23/17.
//  Copyright © 2017 Gina Ratto. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    @IBAction func onSignUp(_ sender: Any) {

        if (emailTextField != nil) && (passwordTextField != nil){
            signUp(emailTextField.text!, password: passwordTextField.text!)
        }
    }
    
    func signUp(_ email: String, password: String){
        var user = PFUser()
        user.password = password
        user.username = email
        
        
        user.signUpInBackground { (succeeded: Bool, error: Error?) in
            if (!succeeded) || (email == " ") || (password == " "){
                let alertController = UIAlertController(title: "Title", message: "Message", preferredStyle: .alert)
                // create an OK action
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    // handle response here.
                }
                // add the OK action to the alert controller
                alertController.addAction(OKAction)
                alertController.title = "Sign Up Error"
                alertController.message = "Enter a valid email address"
                self.present(alertController, animated: true){}
            }else{
                print("new user")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    
    @IBAction func onLogin(_ sender: Any) {
        var email: String? = emailTextField.text
        var password: String? = passwordTextField.text
        var user = PFUser()
        user.username = email
        user.password = password
        
        PFUser.logInWithUsername(inBackground: email!, password: password!) {(user: PFUser?, error: Error?) in
            if (user != nil){
                print("logged in")
                self.performSegue(withIdentifier: "ChatPush", sender: nil)
            } else {
                let alertController = UIAlertController(title: "Title", message: "Message", preferredStyle: .alert)
                
                // create an OK action
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    // handle response here.
                }
                // add the OK action to the alert controller
                alertController.addAction(OKAction)
                alertController.title = "Login Error"
                alertController.message = "Enter a valid username and password"
                self.present(alertController, animated: true){}
            }
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
