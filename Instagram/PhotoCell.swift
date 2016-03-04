//
//  PhotoCell.swift
//  Instagram
//
//  Created by Eduardo Nieves on 3/2/16.
//  Copyright © 2016 Eduardo Nieves. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PhotoCell: UITableViewCell {

   

    @IBOutlet weak var postImage: PFImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var captionLabel: UILabel!
 
    @IBOutlet weak var timeStampLabel: UILabel!
    
    var instagramPost: PFObject!{
        didSet {
            
            captionLabel.text = instagramPost["caption"] as? String
          self.postImage.file = instagramPost!["media"] as? PFFile
            self.postImage.loadInBackground()
            
            let username = PFUser.currentUser()?.username as String!
            usernameLabel.text = username
            
            
            let createdAt = instagramPost?.createdAt
            
            if createdAt != nil {
                var formatter = NSDateFormatter()
                formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
                
                
                timeStampLabel.text = calculateTime((createdAt?.timeIntervalSinceNow)!)
            } else {
                timeStampLabel.hidden = true
            }
            
            let caption = instagramPost!["caption"] as? String
            if caption != nil {
                captionLabel.text = instagramPost!["caption"] as? String
                
            } else {
                captionLabel.hidden = true
            }

        }
    }
   

    func calculateTime(timeIntervalSinceNow: NSTimeInterval) -> String{
        
        var rawTime = Int(timeIntervalSinceNow)
        var time: Int = 0
        var timeChar = ""
    
        print("rawTime:\(rawTime)")
        if (rawTime <= 60) {
            time = rawTime
            timeChar = "s"
        } else if ((rawTime/60) <= 60) {
            time = (rawTime/60) * (-1)
            timeChar = "m"
        } else if (rawTime/60/60 <= 24) {
            time = (rawTime/60/60)
            timeChar = "h"
        } else if (rawTime/60/60/24 <= 365) {
            time = rawTime/60/60/24
            timeChar = "d"
        } else if (rawTime/(3153600) <= 1) {
            
            time = rawTime/60/60/24/365
            timeChar = "y"
        }
        
        return "\(time)\(timeChar)"
    }
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
