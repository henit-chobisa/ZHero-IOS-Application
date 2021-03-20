//
//  senderTableViewCell.swift
//  ICLO
//
//  Created by Henit Work on 26/01/21.
//

import UIKit
import Canvas

class senderTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var message: UILabel!
    
    @IBOutlet weak var mainview: CSAnimationView!
    @IBOutlet weak var additional: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.mainview.delay = 0.1
            self.mainview.duration = 0.3
            self.mainview.type = "pop"
            self.mainview.startCanvasAnimation()
            
            self.mainview.layer.cornerRadius = self.mainview.frame.width/10
           
            self.message.clipsToBounds = true
            
            
            
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
