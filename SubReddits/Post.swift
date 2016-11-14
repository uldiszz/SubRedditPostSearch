//
//  Post.swift
//  SubReddits
//
//  Created by Uldis Zingis on 14/11/16.
//  Copyright © 2016 Uldis Zingis. All rights reserved.
//

import Foundation

class Post {
    let kTitle = "title"
    let kAuthor = "author"
    let kUrl = "url"
    
    let title: String
    let author: String
    let url: String

    init(title: String, author: String, url: String) {
        self.title = title
        self.author = author
        self.url = url
    }

    init?(dict: [String: Any]) {
        guard let title = dict[kTitle] as? String,
             let author = dict[kAuthor] as? String,
             let url = dict[kUrl] as? String else { return nil }
        self.title = title
        self.author = author
        self.url = url
    }
}
