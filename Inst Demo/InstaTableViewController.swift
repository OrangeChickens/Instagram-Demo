//
//  InstaTableViewController.swift
//  Inst Demo
//
//  Created by Yicheng Liang on 9/24/15.
//  Copyright © 2015 Yicheng Liang. All rights reserved.
//

import UIKit

class InstaTableViewController: UITableViewController {
    @IBOutlet weak var posts: UILabel!
    @IBOutlet weak var following: UILabel!
    @IBOutlet weak var followers: UILabel!
    @IBOutlet weak var ClickedUserFollowers: UILabel!
    @IBOutlet weak var ClickedUserPosts: UILabel!
    @IBOutlet weak var ClickedUserFollowing: UILabel!
    @IBOutlet var tapReconizer: UITapGestureRecognizer!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var ClickedUserImage: UIImageView!
    @IBOutlet weak var refresh: UIRefreshControl!
    var flag = false // indicate we should toggle header view or not.
    var userID = "1"
    var profilePicture = "1"
    var index = NSIndexPath(forRow: 0, inSection: 0)
    var medias:[InstagramDemo.media] = []
    var mediaCellPopulated = false
        //refresh data action
    func refresh(sender:AnyObject)
    {
        if flag == true {
            updateData()
        }
        else {
        // Updating your data here...
        InstagramDemo().fetchMediaData{ (medias:[InstagramDemo.media]) -> () in
            self.medias = medias
            self.tableView.reloadData()
    
            }
        }

        self.refreshControl?.endRefreshing()
    }
    
    override func viewDidLoad() {
        self.refreshControl?.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        super.viewDidLoad()
        toggleHeader()
        //resize image to a circle
        self.ClickedUserImage.layer.borderWidth = 1
        self.ClickedUserImage.layer.masksToBounds = false
        self.ClickedUserImage.layer.borderColor = UIColor.blackColor().CGColor
        self.ClickedUserImage.layer.cornerRadius = self.ClickedUserImage.frame.height/2
        self.ClickedUserImage.clipsToBounds = true
        // if clicked into userPage, update userPage Data, else update popular media for the feed page
        if flag == true {
            updateData()
        }
        else {
        InstagramDemo().fetchMediaData{ (medias:[InstagramDemo.media]) -> () in
            self.medias = medias
            self.tableView.reloadData()
            }
        }
    }
    
    
    // update userPrifle page'data
    func updateData() {
    dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.rawValue), 0))  {
        InstagramDemo().fetchUserProfileData(userID, callback: {userProfile  in
            self.ClickedUserFollowers.text = String(userProfile.numberOfFollowers) + "\nfollowers"
            self.ClickedUserFollowers.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
            self.ClickedUserFollowing.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
            self.ClickedUserPosts.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
            self.ClickedUserFollowing.text = String(userProfile.numberOfFollowing)
            self.ClickedUserPosts.text = String(userProfile.numberOfPost)
            self.posts.font = UIFont(name: self.ClickedUserPosts.font.fontName, size: 10)
            self.following.font = UIFont(name: self.ClickedUserPosts.font.fontName, size: 10)
            self.followers.font = UIFont(name: self.ClickedUserPosts.font.fontName, size: 10)
            self.posts.textColor = UIColor.grayColor()
            self.followers.textColor = UIColor.grayColor()
            self.following.textColor = UIColor.grayColor()
            if let url = NSURL(string: self.profilePicture ) {
                if let data = NSData(contentsOfURL: url){
                    if let photo = UIImage(data: data){
                        self.ClickedUserImage?.image = photo
                    }
                    
                } else {
                    self.ClickedUserImage?.image = UIImage(named: "World")
                }
            }
        dispatch_async(dispatch_get_main_queue()) {
            InstagramDemo().fetchRecentMediaData(self.userID, callback: { (medias:[InstagramDemo.media]) -> () in
                self.medias = medias
                self.tableView.reloadData()
                    })
                }
           // self.tableView.reloadData()
            
            })
       
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return medias.count
    }
    // spacing for cell
    override func tableView(_ tableView: UITableView,
        heightForHeaderInSection section: Int) -> CGFloat { return 30
    }
    //spacing for footer
    override func tableView(_ tableView: UITableView,
        heightForFooterInSection section: Int) -> CGFloat { return 10
            
    }
    //set footer view color to white
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 40))
        footerView.backgroundColor = UIColor.whiteColor()
        
        return footerView
    }
    //
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //1 for photocell, the rest for comments.
        return medias[section].comments.count + 1
       
    }
    // so i have row 1 for media, other rows for comments and customized comments cell separatorStyle.
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.row == 0){ // first row to media.
            let cell = tableView.dequeueReusableCellWithIdentifier("PhotoCell", forIndexPath: indexPath) as!MediaTableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            let currentMedia = medias[indexPath.section]
            cell.media = currentMedia
            return cell
        //comments row
        }else {
            tableView.separatorStyle = UITableViewCellSeparatorStyle.None // take out the line separator.
            let cell = tableView.dequeueReusableCellWithIdentifier("CommentsCell", forIndexPath: indexPath) as!CommentTableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            let currentMedia = medias[indexPath.section]
            cell.row = indexPath.row
            cell.media = currentMedia
            return cell
        }
       }
    
    // populate header info
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as! HeaderTableViewCell
        // cell  = self
        //self.tapReconizer = UITapGestureRecognizer(target: self, action: "didTap:")
        //self.tableView.addGestureRecognizer(self.tapReconizer)
        let currentHeader = medias[section]
        cell.header = currentHeader
        return cell

    }
//    func didTap(recognizer: UIGestureRecognizer) {
//        if recognizer.state == UIGestureRecognizerState.Ended {
////            let tapLocation = recognizer.locationInView(self.tableView)
////            if let tapIndexPath = tableView.indexPathForRowAtPoint(tapLocation) {
////                if let TapCell = self.tableView.cellForRowAtIndexPath(tapIndexPath) {
////                    // Swipe happened. Do stuff!
////                    self.performSegueWithIdentifier("showProfile", sender: TapCell)
////
////                }
////            }
//                self.performSegueWithIdentifier("showProfile", sender: recognizer)
//
//        }
//    }
//    func didSelectUserHeaderTableViewCell(Selected: Bool, UserHeader: UserHeaderTableViewCell) {
//        print("Cell Selected!")
//    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }


    // to toggle the headerView
    func toggleHeader(){
        if flag
        { tableView.tableHeaderView = self.profileView }
        else
        { tableView.tableHeaderView = nil }
    }
    
    // MARK: - Navigation

     //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destilonationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "showProfile") {
            let instaViewController = segue.destinationViewController as! InstaTableViewController
            instaViewController.flag = true
            let userInfo  = sender?.view as? HeaderTableViewCell
            let userHeader = userInfo!.header
            var userID = userHeader?.userId
            instaViewController.title = userHeader?.userName
            instaViewController.userID = userID! // set the segue views userID
            instaViewController.profilePicture = (userHeader?.profilePicture)!
     
        }
    }
    
    
    
}
