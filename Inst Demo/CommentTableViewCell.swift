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
//                var myString:NSString = setMedia.comments[row].from + ":" + setMedia.comments[row].text
//                let length = setMedia.comments[row].from.endIndex
//                var myMutableString = NSMutableAttributedString()
//                myMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSRange(location:0,length:4))
//                

                
               
                   // self.commentText?.text = setMedia.comments[row].text
                
                var attrString: NSMutableAttributedString = NSMutableAttributedString(string: setMedia.comments[row].from)
                var descString: NSMutableAttributedString = NSMutableAttributedString(string: ":" + setMedia.comments[row].text)
                descString.addAttribute(NSForegroundColorAttributeName, value: UIColor.blackColor(), range: NSMakeRange(0, descString.length))
                attrString.addAttribute(NSForegroundColorAttributeName, value: UIColor.grayColor(), range: NSMakeRange(0, attrString.length))
                attrString.appendAttributedString(descString);
               // print(attrString)
               // self.CommentUser?.text = setMedia.comments[row].from + ":" + setMedia.comments[row].text
                //let string = setMedia.comments[row].from + ":" + setMedia.comments[row].text as NSString
                //var attributedString = NSMutableAttributedString(string: string as String)
//                attributedString.addAttributes(, range: string.rangeOfString(setMedia.comments[row].from))
                self.CommentUser?.attributedText = attrString
                self.CommentUser.font = UIFont(name: CommentUser.font.fontName, size: 15)
                
            }
            
                
            
        }}
    


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
