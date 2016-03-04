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

   
    @IBOutlet weak var profileImage: UIImageView!

    @IBOutlet weak var postedImage: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var captionLabel: UILabel!
 
    @IBOutlet weak var timeStampLabel: UILabel!
    
    var getPhotoandCaption: PFObject! {
        didSet {
            self.captionLabel.text = getPhotoandCaption["caption"] as? String
        
            let username = PFUser.currentUser()?.username as String!
            usernameLabel.text = username
            
            let createdAt = getPhotoandCaption?.createdAt
            
            if createdAt != nil {
                var formatter = NSDateFormatter()
                formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
                
            
                timeStampLabel.text = calculateTime((createdAt?.timeIntervalSinceNow)!)
            } else {
                timeStampLabel.hidden = true
            }

            
           let user = PFUser.currentUser()
            
            if user!["profileImage"] == nil {
                profileImage.image = UIImage(named: "profileDefault.png")
            } else {
                let profilePicture = user!["profileImage"] as! PFFile
                profilePicture.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                    if (error == nil) {
                        self.profileImage.image = UIImage(data:imageData!)
                    }
            }
            }
            
        
            if let userPicture = /*PFUser.currentUser()?*/getPhotoandCaption["media"] as? PFFile {
                userPicture.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                    if (error == nil) {
                        self.postedImage.image = UIImage(data:imageData!)
                    }
                }
            }
        }
    }
    
    func calculateTime(timeIntervalSinceNow: NSTimeInterval) -> String{
        
        var rawTime = Int(timeIntervalSinceNow)
        var time: Int = 0
        var timeChar = ""
        
        rawTime = rawTime * (-1)
        
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
        
        return "\(time * -1)\(timeChar)"
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