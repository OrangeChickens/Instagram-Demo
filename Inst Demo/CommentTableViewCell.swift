//
//  CommentTableViewCell.swift
//  Inst Demo
//
//  Created by Yicheng Liang on 9/26/15.
//  Copyright © 2015 Yicheng Liang. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    //@IBOutlet weak var commentText: UILabel!
    @IBOutlet weak var CommentUser: UILabel!
    var row = 1
    var media: InstagramDemo.media? {
        didSet {
            if let setMedia = media {
                    row = row - 1
                var attrString: NSMutableAttributedString = NSMutableAttributedString(string: setMedia.comments[row].from)
                var descString: NSMutableAttributedString = NSMutableAttributedString(string: ":" + setMedia.comments[row].text)
                descString.addAttribute(NSForegroundColorAttributeName, value: UIColor.blackColor(), range: NSMakeRange(0, descString.length))
                attrString.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 18.0/255.0, green: 86.0/255.0, blue: 136.0/255.0, alpha: 1.0), range: NSMakeRange(0, attrString.length))
                attrString.appendAttributedString(descString)
                self.CommentUser?.attributedText = attrString
                self.CommentUser.font = UIFont(name: CommentUser.font.fontName, size: 15)
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
