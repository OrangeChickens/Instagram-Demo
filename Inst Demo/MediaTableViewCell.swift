//
//  MediaTableViewCell.swift
//  Inst Demo
//
//  Created by Yicheng Liang on 9/26/15.
//  Copyright © 2015 Yicheng Liang. All rights reserved.
//

import UIKit

class MediaTableViewCell: UITableViewCell {

    @IBOutlet weak var caption: UILabel!
    @IBOutlet weak var NumberOfLike: UILabel!
    @IBOutlet weak var TakenPhoto: UIImageView!
    var populated = false
    var media: InstagramDemo.media? {
        didSet {
            if let setMedia = media {

                self.caption.text = setMedia.text
                self.NumberOfLike.text = "❤️" + setMedia.likes + " likes"
                //headPic.text = setHeader.profilePicture
                if let url = NSURL(string: setMedia.takenPhoto) {
                    if let data = NSData(contentsOfURL: url){
                        
                        if let photo = UIImage(data: data){
                            
                            TakenPhoto?.image = photo
                        }
                        
                    } else {
                        self.TakenPhoto?.image = UIImage(named: "World")
                    }
                }
                
            }
            self.populated = true
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