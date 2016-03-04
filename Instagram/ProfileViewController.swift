//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Eduardo Nieves on 3/4/16.
//  Copyright © 2016 Eduardo Nieves. All rights reserved.
//

import UIKit

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
            
            // Do something with the images (based on your use case)
          
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
