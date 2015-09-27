//
//  HeaderTableViewCell.swift
//  Inst Demo
//
//  Created by Yicheng Liang on 9/26/15.
//  Copyright © 2015 Yicheng Liang. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var headPic: UIImageView!
    @IBOutlet weak var headTime: UILabel!
    @IBOutlet weak var headUser: UILabel!
    var header: InstagramDemo.media? {
        didSet {
            if let setHeader = header {
                self.headUser.text = setHeader.userName
                let timeInterval = Double(setHeader.time)
                let date = NSDate(timeIntervalSince1970: timeInterval!)
                let formatter = NSDateFormatter()
                let usDateFormat = NSDateFormatter.dateFormatFromTemplate("MMddyyyy", options: 0, locale: NSLocale(localeIdentifier: "en-US"))
                formatter.dateFormat = usDateFormat
                let usSwiftDayString = formatter.stringFromDate(date)

                self.headTime.text = usSwiftDayString
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
