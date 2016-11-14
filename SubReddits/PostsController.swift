//
//  PostsController.swift
//  SubReddits
//
//  Created by Uldis Zingis on 14/11/16.
//  Copyright © 2016 Uldis Zingis. All rights reserved.
//

import Foundation

class PostsController {
    static let sharedInstance = PostsController()

    var posts: [Post] = []

    func createPostFromDict(dict: [String: Any]) {
        guard let post = Post(dict: dict) else { return }
        self.posts.append(post)
    }

    func clearSearch() {
        self.posts = []
    }

    func searchForPostsIn(subreddit: String, completion: @escaping ((Bool, Error?) -> Void)) {
        guard let url = URL(string: "https://www.reddit.com/r/\(subreddit.lowercased())/top/.json?count=20") else { return }

        NetworkController.performRequest(for: url, httpMethod: .Get, urlParameters: nil, body: nil) { (data, error) in

            guard let data = data else { NSLog("No data returned."); completion(false, nil); return }

            if error != nil {
                NSLog("Error while searching for posts: \(error?.localizedDescription)")
                completion(false, error)
                return
            }

            guard let dict = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any] else { NSLog("Error serializing JSON data: \(error)"); completion(false, error); return }

            guard let dataDict = dict["data"] as? [String: Any], let childrenDict = dataDict["children"] as? [[String: Any]] else { return }

            self.posts = []
            for childDict in childrenDict {
                if let postDict = childDict["data"] as? [String: Any] {
                    if let post = Post(dict: postDict) {
                        self.posts.append(post)
                    }
                }
            }

            completion(true, nil)
        }
    }
}


