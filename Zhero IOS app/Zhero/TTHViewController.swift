//
//  TTHViewController.swift
//  Zhero
//
//  Created by Henit Work on 20/03/21.
//

import UIKit
import WebKit
import Firebase
import Kingfisher


class TTHViewController: UIViewController {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var imaheView: UIImageView!
    let db = Firestore.firestore()
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var web: WKWebView!
    @IBOutlet weak var myview: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myview.layer.cornerRadius = 30
        topView.layer.cornerRadius = 20
        imaheView.layer.cornerRadius = imaheView.frame.height/2
        let webView = WKWebView(frame: myview.frame)
        view.addSubview(webView)
        let url = URL(string: "http://127.0.0.1:5501/index.html")
        let request = URLRequest(url: url!)
        webView.load(request)
        myview.isMultipleTouchEnabled = false
        
        db.collection((Auth.auth().currentUser?.email)!).getDocuments { (querysnapsht, error) in
            let data = querysnapsht!.documents
            for doc in data {
                let name = doc["Name"] as! String
                let pic = doc["Photo"] as! String
                let url = URL.init(string: pic)
                let imageresourse = ImageResource.init(downloadURL: url!)
                self.imaheView.kf.setImage(with: imageresourse) { (result) in
                   print("Success")
                }
                self.nameLabel.text = name
            }
            
        }
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
