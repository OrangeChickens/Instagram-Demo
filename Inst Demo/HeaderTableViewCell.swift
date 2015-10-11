//
//  HeaderTableViewCell.swift
//  Inst Demo
//
//  Created by Yicheng Liang on 9/26/15.
//  Copyright © 2015 Yicheng Liang. All rights reserved.
//

import UIKit
import DateTools


class HeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var headPic: UIImageView!
    @IBOutlet weak var headTime: UILabel!
    @IBOutlet weak var headUser: UILabel!
    var instanceDate: NSDate = NSDate()
    var header: InstagramDemo.media? {
        didSet {
            self.headPic.layer.borderWidth = 1
            self.headPic.layer.masksToBounds = false
            self.headPic.layer.borderColor = UIColor.blackColor().CGColor
            self.headPic.layer.cornerRadius = self.headPic.frame.height/2
            self.headPic.clipsToBounds = true
            if let setHeader = header {
                self.headUser.text = setHeader.userName
                self.headUser.textColor = UIColor(red: 18.0/255.0, green: 86.0/255.0, blue: 136.0/255.0, alpha: 1.0)
                let timeInterval = Double(setHeader.time)
                let date = NSDate(timeIntervalSince1970: timeInterval!)
                let stringTime = instanceDate.shortTimeAgoSinceDate(date) // Time that it posted relative to now
                self.headTime.text = stringTime
                if let url = NSURL(string: setHeader.profilePicture) {
                                if let data = NSData(contentsOfURL: url){
                                    
                                    if let photo = UIImage(data: data){

                                        headPic?.image = photo
                                    }
                                    
                                } else {
                                    self.headPic?.image = UIImage(named: "World")
                                }
                            }
                
            }
        }
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
