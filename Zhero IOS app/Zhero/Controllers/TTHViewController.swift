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
//        let path = Bundle.main.path(forResource: "index", ofType: "html")
//        let url = URL(string: "https://igsaves.com/hand/")
//        let url = URL(fileURLWithPath: path!)
        let url = URL(string: "http://127.0.0.1:5501")
        let request = URLRequest(url: url!)
        webView.load(request)
        myview.isMultipleTouchEnabled = false
        webView.allowsLinkPreview = true
        webView.accessibilityRespondsToUserInteraction = true
        
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
    }
}
//code for the page
