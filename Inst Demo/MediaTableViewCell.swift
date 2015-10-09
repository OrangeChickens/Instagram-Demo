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
    @IBOutlet weak var NumberOfLike: UILabel!
    @IBOutlet weak var TakenPhoto: UIImageView!
    var populated = false
    // Currently this is an unbounded cache - you probably want to use something like a LRU
    var cachedImages = [String: UIImage]()
    var media: InstagramDemo.media? {
        didSet {
            if let setMedia = media {
                self.caption.text = setMedia.text
                self.NumberOfLike.text = "❤️" + setMedia.likes + " likes"
                loadImageForMediaCell(setMedia.takenPhoto, id: setMedia.userId)
                
            }
            self.populated = true
        }
        
    }
    
    func loadImageForMediaCell(url:String, id: String){
        if let image = cachedImages[id] { // already in cache
            TakenPhoto?.image = image
        } else {
            if let url = NSURL(string: url) { // need tozfetch
                dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.rawValue), 0))  {
                    if let data = NSData(contentsOfURL: url) {
                        if let avatarSquare = UIImage(data:data) {
                            self.cachedImages.updateValue(avatarSquare, forKey: id)
                            // Because this happens asynchronously in the background, we need to check that by the time we get here
                            // that the cell that requested the image is still the one that is being displayed.
                            // If it is not, we would have cached the image for the future but we will not display it for now.
                            if(self.media?.userId == id) {
                                dispatch_async(dispatch_get_main_queue()) {
                                    TakenPhoto?.image = avatarSquare
                                }
                            }
                        }
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
