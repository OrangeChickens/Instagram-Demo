//
//  InstaTableViewController.swift
//  Inst Demo
//
//  Created by Yicheng Liang on 9/24/15.
//  Copyright © 2015 Yicheng Liang. All rights reserved.
//

import UIKit

class InstaTableViewController: UITableViewController {
    
    @IBOutlet weak var refresh: UIRefreshControl!
    var medias:[InstagramDemo.media] = []
    var mediaCellPopulated = false
    //refresh data. Adapted from StackOverFlow
    func refresh(sender:AnyObject)
    {
        // Updating your data here...
        InstagramDemo().fetchMediaData{ (medias:[InstagramDemo.media]) -> () in
            self.medias = medias
            self.tableView.reloadData()
    
        }

        self.refreshControl?.endRefreshing()
    }
    
    override func viewDidLoad() {
       //tableView.backgroundColor = UIColor.grayColor()
        self.refreshControl?.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        super.viewDidLoad()
        InstagramDemo().fetchMediaData{ (medias:[InstagramDemo.media]) -> () in
            self.medias = medias
            self.tableView.reloadData()
          
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
            tableView.rowHeight = 550 // magic number.... I ll fix this later.
           
            let cell = tableView.dequeueReusableCellWithIdentifier("PhotoCell", forIndexPath: indexPath) as!MediaTableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            let currentMedia = medias[indexPath.section]
            cell.media = currentMedia
            return cell
        //comments row
        }else {
            tableView.rowHeight = 15 // comments are short
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
        let currentHeader = medias[section]
        cell.header = currentHeader
        
        
        return cell

    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
