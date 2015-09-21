//
//  InstagramData.swift
//  Inst Demo
//
//  Created by Yicheng Liang on 9/20/15.
//  Copyright © 2015 Yicheng Liang. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

//Instagram models classes and each modesl is associated with a fetch and populate data function.
public class InstagramDemo {
    var testId = ""
    // popular medias Struc containning all information we can get from media api from instagram
    struct media {
        let takenPhoto: String
        let userId: String
        let userName: String
        let text: String
        let profilePicture: String
        let tag: [JSON]
        let comments:[JSON]
        let likes: String
    }
    
    //User UserProfile struc containning all info we can get from userprofile api from instagram
    struct userProfile {
        let numberOfPost:String
        let numberOfFollowers: String
        let numberOfFollowing: String
        
    }
    
    // fetch popular media data from instagram api
    func fetchMediaData(callback: ([media]) -> Void) {
        // Fetch media data
        Alamofire.request(.GET, "https://api.instagram.com/v1/media/popular?client_id=c953ffadb974463f9f6813fc4fc91673")
            .responseJSON { request, response, jsonObj in
               // print(jsonObj.value)
                self.populateMediaWith(jsonObj.value!, callback: callback)
        }
    }
    //populate poplular media inforamtion
    func populateMediaWith(data: AnyObject?, callback: ([media]) -> Void) {
        let json = JSON(data!)
        var medias = [media]()
       // print(json["data"].arrayValue[])
        for member in json["data"].arrayValue{
            medias.append(media(takenPhoto: member["link"].stringValue, userId:(member["user"]["id"]).stringValue, userName:(member["user"]["username"]).stringValue, text:member["caption"]["text"].stringValue,profilePicture:member["user"]["profile_picture"].stringValue, tag: member["tags"].arrayValue, comments:member["comments"].arrayValue, likes:member["likes"]["count"].stringValue))
    }
        callback(medias)
        

}
    // fetch userProfile data from instagram api
    func fetchUserProfileData(id: String, callback: (userProfile) -> Void) {
        // Fetch userProfile data
        Alamofire.request(.GET, "https://api.instagram.com/v1/users/" + id + "/?client_id=c953ffadb974463f9f6813fc4fc91673")
            .responseJSON { _, _, jsonObj in
                self.populateUserProfileWith(jsonObj.value!, callback: callback)
        }
    }
    //populate media inforamtion
    func populateUserProfileWith(data: AnyObject?, callback: (userProfile) -> Void) {
            let json = JSON(data!)
        callback(userProfile(numberOfPost: json["data"]["counts"]["media"].stringValue, numberOfFollowers: json["data"]["counts"]["followed_by"].stringValue, numberOfFollowing: json["data"]["counts"]["follows"].stringValue))

        
        
    }
    //fetch recent medias for a specific user based on user_id
    // fetch media data from instagram api
    func fetchRecentMediaData(id: String, callback: ([media]) -> Void) {
        // Fetch media data
        Alamofire.request(.GET,  "https://api.instagram.com/v1/users/" + id +  "/media/recent/?client_id=c953ffadb974463f9f6813fc4fc91673")
            .responseJSON { request, response, jsonObj in
                // print(jsonObj.value)
                self.populateMediaWith(jsonObj.value!, callback: callback)
        }
    }
   
}

