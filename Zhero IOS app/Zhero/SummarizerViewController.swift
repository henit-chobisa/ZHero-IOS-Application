//
//  SummarizerViewController.swift
//  Zhero
//
//  Created by Henit Work on 20/03/21.
//

import UIKit
import WebKit
import Firebase
import Kingfisher

class SummarizerViewController: UIViewController {
    
    @IBOutlet weak var sumView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var imaheView: UIImageView!
    let db = Firestore.firestore()
    @IBOutlet weak var nameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        topView.layer.cornerRadius = 20
        imaheView.layer.cornerRadius = imaheView.frame.height/2
        
        
        let webView = WKWebView(frame: sumView.frame)
//        let htmlPath = Bundle.main.path(forResource: "index 2", ofType: "html")
        view.addSubview(webView)
//        let url = URL(fileURLWithPath: htmlPath!)
        let url = URL(string: "https://igsaves.com/zhero/")
        let request = URLRequest(url: url!)
        webView.load(request)
        
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
