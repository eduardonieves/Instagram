//
//  PhotosViewController.swift
//  Instagram
//
//  Created by Eduardo Nieves on 3/2/16.
//  Copyright © 2016 Eduardo Nieves. All rights reserved.
//

import UIKit
import Parse

class PhotosViewController: UIViewController, UITableViewDataSource,UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var noPostView: UIView!
   var posts:[PFObject]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        let logo = UIImage(named: "instagram_name.png")
        let tintedLogo = logo!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        
        let imageView = UIImageView(image:tintedLogo)
        imageView.tintColor = UIColor.whiteColor()
        self.navigationItem.titleView = imageView
        
        
        getPosts { (posts, error) -> Void in
            self.posts = posts
            self.tableView.reloadData()
        }
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        print(posts)
        
        tableView.reloadData()
       
    }
    
    override func viewDidAppear(animated: Bool) {
        getPosts { (posts, error) -> Void in
            self.posts = posts
            self.tableView.reloadData()
        }
        tableView.reloadData()       

    }
    func refreshControlAction(refreshControl: UIRefreshControl) {
        //Connect to the API to have the last update
        getPosts { (posts, error) -> Void in
            self.posts = posts
            self.tableView.reloadData()
        }
        
        //update the collection data source
        refreshControl.endRefreshing()
    }
   
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if posts?.count>0 {
            noPostView.hidden = true
            return (posts?.count)!
        }else {
            noPostView.hidden = false
            return 0
        }
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PhotoCell", forIndexPath: indexPath) as! PhotoCell
        
        let post = posts![indexPath.row]
        
        cell.getPhotoandCaption = post
    
        return cell
        
    }
    func getPosts(completion: (posts: [PFObject]?, error: NSError?)-> Void){
        let query = PFQuery(className: "Post")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.limit = 20
        query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
            if let posts = posts {
                completion(posts: posts, error: nil)
            } else {
                print("failed to get data")
            }
        }
    }

   
    @IBAction func onLogout(sender: AnyObject) {
        PFUser.logOut()
performSegueWithIdentifier("LogoutSegue", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
