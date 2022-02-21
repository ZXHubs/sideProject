//
//  FeedModel.swift
//  DuoYinDemo
//
//  Created by ZhangX on 2022/2/21.
//

import Foundation

struct FeedModel {
    
    struct Author {
        var id: String?
        var name: String?
        var avatarURL: URL?
    }
    
    var id: String?
    
    var videoURL:URL? = URL(string: "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
    
    var coverURL: URL?
    
    var author: Author?
    
    var likeCount: String?
    
}
