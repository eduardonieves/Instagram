//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Eduardo Nieves on 3/4/16.
//  Copyright © 2016 Eduardo Nieves. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    
    
    var image: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logo = UIImage(named: "instagram_name.png")
        let tintedLogo = logo!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        
        let imageView = UIImageView(image:tintedLogo)
        imageView.tintColor = UIColor.whiteColor()
        self.navigationItem.titleView = imageView

        // Do any additional setup after loading the view.
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func updateProfileImage(){
        
        var user = PFUser.currentUser()!
        
        
    }
    
    @IBAction func pickPhoto(sender: AnyObject) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(vc, animated: true, completion: nil)
        

    }
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            // Get the image captured by the UIImagePickerController
            let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            
            getPFFileFromImage(originalImage)
             let user = PFUser.currentUser()!
            
            user["profileImage"] = getPFFileFromImage(originalImage)
            
            user.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                   print("The object has been saved")
                } else {
                  print("The object did not saved")
                }
            }

            dismissViewControllerAnimated(true, completion: nil)

            // Do something with the images (based on your use case)
          
    }
    func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }

    @IBAction func onLogout(sender: AnyObject) {
        PFUser.logOut()
        performSegueWithIdentifier("LogoutSegue", sender: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
