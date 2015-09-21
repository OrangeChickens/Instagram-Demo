//
//  Inst_DemoTests.swift
//  Inst DemoTests
//
//  Created by Yicheng Liang on 9/20/15.
//  Copyright © 2015 Yicheng Liang. All rights reserved.
//

import XCTest
@testable import Inst_Demo

class Inst_DemoTests: XCTestCase {
    let c = InstagramDemo()

    override func setUp() {
        super.setUp()

        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPopularMedias() {
        c.fetchMediaData{ (medias:[InstagramDemo.media]) -> () in
            XCTAssertEqual(24, medias.count)
            
        }

        
    }
    //test if I can get users profile inforamtion from a given userId
    func testUserProfile() {
        let userId = "216093910"; // a freind of mine's ID
        let userId1 = "x"; // an invalid id
        c.fetchUserProfileData (userId, callback: {(org: InstagramDemo.userProfile) -> () in
            print(org.numberOfFollowing)
            XCTAssertEqual(399, org.numberOfPost)
            XCTAssertEqual(282, org.numberOfFollowers)
            XCTAssertEqual(205, org.numberOfFollowing) // I got these magic numbers from paw then compare it with my requst function to see if 
                                                        // get user's profile data
            
        })
        XCTAssertEqual("not a valid id",  c.fetchUserProfileData (userId1, callback: {(org: InstagramDemo.userProfile) -> () in
            
        }))
    }
    
    func testRecentMedia(){
        let userId = "216093910"; // a freind of mine's ID
        let userId1 = "x"; // an invalid id
        InstagramDemo().fetchRecentMediaData (userId, callback: {(org: [InstagramDemo.media]) -> () in
            
            XCTAssertEqual(20, org.count)
            
        })
        XCTAssertEqual("not a valid id",  c.fetchRecentMediaData (userId1, callback: {(org: [InstagramDemo.media]) -> () in
            
        }))
    }
    
}
