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
        let time: String
        let comments:[Comment]
        let likes: String
    }
    struct Comment {
        let text: String
        let from: String
    }
    
    //User UserProfile struc containning all info we can get from userprofile api from instagram
    struct userProfile {
        let numberOfPost:Int
        let numberOfFollowers: Int
        let numberOfFollowing: Int
        
    }
    
    // fetch popular media data from instagram api
    func fetchMediaData(callback: ([media]) -> Void) {
        // Fetch media data
        Alamofire.request(.GET, "https://api.instagram.com/v1/media/popular?client_id=c953ffadb974463f9f6813fc4fc91673")
            .responseJSON { request, response, jsonObj in
                self.populateMediaWith(jsonObj.value!, callback: callback)
        }
    }
    //populate poplular media inforamtion
    func populateMediaWith(data: AnyObject?, callback: ([media]) -> Void) {
        let json = JSON(data!)
        var medias = [media]()
        for member in json["data"].arrayValue{
            var comments = [Comment]()
            for comment in member["comments"]["data"].arrayValue {
                comments.append(Comment(text: comment["text"].stringValue, from: comment["from"]["username"].stringValue))
            }
            medias.append(media(takenPhoto: member["images"]["standard_resolution"]["url"].stringValue, userId:(member["user"]["id"]).stringValue, userName:(member["user"]["username"]).stringValue, text:member["caption"]["text"].stringValue,profilePicture:member["user"]["profile_picture"].stringValue, time: member["created_time"].stringValue, comments:comments, likes:member["likes"]["count"].stringValue))
    }
        callback(medias)
        

}
    // fetch userProfile data from instagram api
    func fetchUserProfileData(id: String, callback: (userProfile) -> Void)->String {
       //check if id is a valid string with integers
        let myInt: Int? = Int(id)
        if(myInt == nil) {
            return "not a valid id"
        }
        // Fetch userProfile data
        Alamofire.request(.GET, "https://api.instagram.com/v1/users/" + id + "/?client_id=c953ffadb974463f9f6813fc4fc91673")
            .responseJSON { _, _, jsonObj in
                self.populateUserProfileWith(jsonObj.value!, callback: callback)
        }
        return "success populated"
    }
    //populate media inforamtion
    func populateUserProfileWith(data: AnyObject?, callback: (userProfile) -> Void) {
            let json = JSON(data!)

        callback(userProfile(numberOfPost: json["data"]["counts"]["media"].intValue, numberOfFollowers: json["data"]["counts"]["followed_by"].intValue, numberOfFollowing: json["data"]["counts"]["follows"].intValue))

        
        
    }
    //fetch recent medias for a specific user based on user_id
    // fetch media data from instagram api
    func fetchRecentMediaData(id: String, callback: ([media]) -> Void)  -> String{
        //check if id is a valid string with integers
        let myInt: Int? = Int(id)
        if(myInt == nil) {
            return "not a valid id"
        }
        // Fetch media data
        Alamofire.request(.GET,  "https://api.instagram.com/v1/users/" + id +  "/media/recent/?client_id=c953ffadb974463f9f6813fc4fc91673")
            .responseJSON { request, response, jsonObj in
                // print(jsonObj.value)
                self.populateMediaWith(jsonObj.value!, callback: callback)
        }
        return "success populated"
    }
   
}

