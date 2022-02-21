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
        var avatarURL: URL? = URL(string: "https://media.dayoftheshirt.com/images/shirts/it8r2/teepublic_hello-lisa-rainbow-apple-teepublic_1557204000.large.png")
    }
    
    var id: String?
    
    var videoURL:URL? = URL(string: "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
    
    var coverURL: URL?
    
    var author: Author?
    
    var likeCount: String?
    
}
