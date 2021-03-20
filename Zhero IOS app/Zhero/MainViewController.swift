//
//  MainViewController.swift
//  Zhero
//
//  Created by Henit Work on 20/03/21.
//

import UIKit
import WebKit
import Firebase
import Kingfisher
import WebKit


class MainViewController: UIViewController {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var imaheView: UIImageView!
    @IBOutlet weak var calView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    let db = Firestore.firestore()
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topView.layer.cornerRadius = 20
        imaheView.layer.cornerRadius = imaheView.frame.height/2
        
        let webView = WKWebView(frame: calView.frame)
        let htmlPath = Bundle.main.path(forResource: "calender", ofType: "html")
        view.addSubview(webView)
        let url = URL(fileURLWithPath: htmlPath!)
//        let url = URL(string: "https://igsaves.com/zhero/")
        let request = URLRequest(url: url)
        webView.load(request)
        calView.isMultipleTouchEnabled = false
        webView.sizeToFit()
        calView.layer.cornerRadius = 20
        webView.layer.cornerRadius = 20
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
        
        
        
        
//        let webView = WKWebView(frame: view.frame)
//        view.addSubview(webView)
//        let url = URL(string: "https://www.youtube.com")
//        let request = URLRequest(url: url!)
//        webView.load(request)
//
        

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
