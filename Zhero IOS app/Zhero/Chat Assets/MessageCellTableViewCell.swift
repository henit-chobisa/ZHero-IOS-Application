//
//  MessageCellTableViewCell.swift
//  ICLO
//
//  Created by Henit Work on 25/01/21.
//

import UIKit
import Canvas

class MessageCellTableViewCell: UITableViewCell {
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var mainview: CSAnimationView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.mainview.delay = 0.1
            self.mainview.duration = 0.3
            self.mainview.type = "pop"
            self.mainview.startCanvasAnimation()
            
            
            self.mainview.clipsToBounds = true
            self.mainview.layer.cornerRadius = self.mainview.frame.width/10
            
            self.userImage.layer.cornerRadius = 10
            self.message.clipsToBounds = true
//            self.message.sizeToFit()
           
           
        }
    
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
