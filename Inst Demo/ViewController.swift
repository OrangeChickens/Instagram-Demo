//
//  ViewController.swift
//  Inst Demo
//
//  Created by Yicheng Liang on 9/20/15.
//  Copyright © 2015 Yicheng Liang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var medias:[InstagramDemo.media] = []
    var id = ""
    override func viewDidLoad() {
        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//        InstagramDemo().fetchMediaData{ (medias:[InstagramDemo.media]) -> () in
//            self.medias = medias
//            //if there is click response to user name
//            //navigate to users profile(recent medias)
//        }
//        
//        InstagramDemo().fetchUserProfileData ("0", callback: {(org: InstagramDemo.userProfile) -> () in
//            
//        print(org.numberOfFollowing) // to see if there is output
//
//    })
//        InstagramDemo().fetchRecentMediaData ("x", callback: {(org: [InstagramDemo.media]) -> () in
//            
//           // print(org) // to see if theres output
//            
//        })

}
    //lock orientation
    override func shouldAutorotate() -> Bool {
        if (UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeLeft ||
            UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeRight ||
            UIDevice.currentDevice().orientation == UIDeviceOrientation.Unknown) {
                return false;
        }
        else {
            return true;
        }
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

