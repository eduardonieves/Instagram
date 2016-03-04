//
//  PostingViewController.swift
//  Instagram
//
//  Created by Eduardo Nieves on 3/3/16.
//  Copyright © 2016 Eduardo Nieves. All rights reserved.
//

import UIKit

class PostingViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate  {

    @IBOutlet weak var postingImageView: UIImageView!
    
    @IBOutlet weak var captionTextField: UITextField!
    
     let imagePicker = UIImagePickerController()
     var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logo = UIImage(named: "instagram_name.png")
        let tintedLogo = logo!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        
        let imageView = UIImageView(image:tintedLogo)
        imageView.tintColor = UIColor.whiteColor()
        self.navigationItem.titleView = imageView
        
        captionTextField.delegate = self
        
        captionTextField.layer.borderWidth = 1
        captionTextField.layer.cornerRadius = 8
        postingImageView?.image=nil
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
    
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        self.postingImageView.image = UIImage(named: "placeholder.png")
        
        // Do any additional setup after loading the view.
    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            // Get the image captured by the UIImagePickerController
            let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            
            // Do something with the images (based on your use case)
            image = editedImage
            postingImageView!.image = image
            // Dismiss UIImagePickerController to go back to your original view controller
            dismissViewControllerAnimated(true, completion: nil)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPickPhoto(sender: AnyObject) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(vc, animated: true, completion: nil)
        
        
    }
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    @IBAction func backHome(sender: AnyObject) {
    performSegueWithIdentifier("HomeSegue", sender: nil)
    }
    @IBAction func postPhoto(sender: AnyObject) {
        if postingImageView?.image != nil && captionTextField.text!.characters.count>0{
            let resizedimage = resize(image, newSize:CGSize(width: 300, height: 200))
            Post.postUserImage(resizedimage, withCaption: captionTextField.text, withCompletion: nil)
            print("succesfully posted")
            
            let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 1 * Int64(NSEC_PER_SEC))
            dispatch_after(time, dispatch_get_main_queue()) {
                self.tabBarController?.selectedIndex = 0
            }
            dismissViewControllerAnimated(true, completion: nil)
            performSegueWithIdentifier("HomeSegue", sender: nil)
        }else {
            let alert = UIAlertController(title: "Empty image or caption", message: "You must add an image and there must be a caption to upload the post", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
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
