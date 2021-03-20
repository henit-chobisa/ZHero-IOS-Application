//
//  RegisterViewController.swift
//  Zhero
//
//  Created by Henit Work on 20/03/21.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage


class RegisterViewController: UIViewController, UINavigationControllerDelegate {

 
    @IBOutlet weak var actIndicator: UIActivityIndicatorView!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var ageFeild: UITextField!
    @IBOutlet weak var phoneFeild: UITextField!
    @IBOutlet weak var nameFeild: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var usernamefeild: UITextField!
    var picker = UIImagePickerController()
    
    let db = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()
        actIndicator.isHidden = true
        profileImage.layer.cornerRadius = profileImage.frame.size.height/2
        goButton.layer.cornerRadius = 10
        nameFeild.layer.cornerRadius = 16
        phoneFeild.layer.cornerRadius = 16
        ageFeild.layer.cornerRadius = 16
        usernamefeild.layer.cornerRadius = 16
        // Do any additional setup after loading the view.
    }
    @IBAction func goHit(_ sender: UIButton) {
        actIndicator.isHidden = false
        actIndicator.startAnimating()
        let data = profileImage.image?.jpegData(compressionQuality: 0.7)
        let imageReference = Storage.storage().reference().child((Auth.auth().currentUser?.email)!).child("\(String(describing: Auth.auth().currentUser?.email)) profile Image")
        imageReference.putData(data!, metadata: nil) { (meta, error2) in
            imageReference.downloadURL { (url, error) in
                self.handwithdatabase(k: url!.absoluteString)
                
              
            }
        }
    }
    
    
    @IBAction func imageChange(_ sender: UIButton) {
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    
    func handwithdatabase(k : String){
        self.db.collection("userList").addDocument(data: ["email" : Auth.auth().currentUser?.email! as Any , "username" : self.usernamefeild.text ?? "No Name" , "photo" : k])
        

        self.db.collection((Auth.auth().currentUser?.email)!).addDocument(data: ["Email" : Auth.auth().currentUser?.email!, "UserName" : usernamefeild.text! ?? "Username_undefined" , "Name" : self.nameFeild.text ?? "No Name" , "Phone" : self.phoneFeild.text ?? "No Phone" , "Age" : self.ageFeild.text , "Photo" : k ])
        
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
    }
    

}
extension RegisterViewController : UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        
        dismiss(animated: true)
        profileImage.image = image
    }
    
    
}
