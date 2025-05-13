//
//  Post.swift
//  InstagramFirebase
//
//  Created by User on 11.05.25.
//

import Foundation

struct Post {
    let documentID: String 
    let username: String
    let caption: String
    let imageUrl: String
    var likeCount: Int
    let isLikedByCurrentUser: Bool
}
