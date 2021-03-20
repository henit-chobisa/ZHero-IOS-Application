//
//  ViewController.swift
//  Zhero
//
//  Created by Henit Work on 20/03/21.
//

import UIKit
import Firebase
import FirebaseAuth
import Canvas

class ViewController: UIViewController {
//    @IBOutlet weak var mainWindow: CSAnimationView!
//    @IBOutlet weak var emailback: UIImageView!
//    @IBOutlet weak var passwordBack: UIImageView!
//    @IBOutlet weak var loginBackgrounf: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var segmentor: UISegmentedControl!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailTextFeild: UITextField!
    @IBOutlet weak var passwordTextFeild: UITextField!
    @IBOutlet weak var registerbutton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        emailback.layer.cornerRadius = 20
//        passwordBack.layer.cornerRadius = 20
//        loginButton.layer.cornerRadius = 20
        indicator.isHidden = true
        loginButton.layer.cornerRadius = 5
     
        emailTextFeild.layer.cornerRadius = 10
        passwordTextFeild.layer.cornerRadius = 10
        
        
        
    }
    
    @IBAction func loginHit(_ sender: UIButton) {
        indicator.isHidden = false
        
        indicator.startAnimating()
        if segmentor.selectedSegmentIndex == 0 {
            
            Auth.auth().signIn(withEmail: emailTextFeild.text!, password: passwordTextFeild.text!) { (result, error) in
                if error == nil {
                    self.indicator.stopAnimating()
                    self.indicator.isHidden = true
                    self.performSegue(withIdentifier: "toMain", sender: self)
                }
                else {
                    self.mainTitle.text = "SignIn Error"
                }
            }
            
        }
        else{
            
            indicator.startAnimating()
            Auth.auth().createUser(withEmail: emailTextFeild.text!, password: passwordTextFeild.text!) { (result, error) in
                if error == nil {
                    self.indicator.isHidden = true
                    self.indicator.stopAnimating()
                    self.performSegue(withIdentifier: "toRegister", sender: self)
                }
                else {
                    self.mainTitle.text = "Registration Error"
                    
                }
            
        }
        
    }
    }
    
   
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            loginButton.setTitle("L O G I N", for: .normal)
            mainTitle.text = "L O G I N"
        }
        else {
            loginButton.setTitle("R E G I S T E R", for: .normal)
            mainTitle.text = "R E G I S T E R"
        }
    }
    


}



