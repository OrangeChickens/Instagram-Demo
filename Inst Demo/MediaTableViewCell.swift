//
//  MediaTableViewCell.swift
//  Inst Demo
//
//  Created by Yicheng Liang on 9/26/15.
//  Copyright © 2015 Yicheng Liang. All rights reserved.
//
//populate media cell

import UIKit

class MediaTableViewCell: UITableViewCell {

    @IBOutlet weak var caption: UILabel!
    @IBOutlet weak var numberOfLike: UILabel!
    @IBOutlet weak var takenPhoto: UIImageView!
    var populated = false
    // Currently this is an unbounded cache - you probably want to use something like a LRU
    var cachedImages = [String: UIImage]()
    var media: InstagramDemo.media? {
        didSet {
            if let setMedia = media {
                self.caption.text = setMedia.text
                self.numberOfLike.text = "❤️" + setMedia.likes + " likes"
                self.takenPhoto.image = nil
                self.takenPhoto.setImageWithURL(NSURL(string: media!.takenPhoto)!)
                
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
