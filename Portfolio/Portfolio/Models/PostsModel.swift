//
//  PostsModel.swift
//  Portfolio
//
//  Created by JPL-ST-SPRING2021 on 5/12/22.
//

import Foundation
import SwiftUI

struct Post: Identifiable {
    var id = UUID()
    
    let postId, username, title, description, uid, postImageUrl: String
    
}

class PostsModel: ObservableObject {
    
    @Published var errorMessage = ""
    @Published var posts: [Post] = []
    
    init() {
        fetchPosts()
        
    }
    
    private func fetchPosts(){
        print("fetching data...")
        FirebaseManager.shared.firestore.collection("posts").getDocuments() { snapshot, error in
                if let error = error {
                    self.errorMessage = "Failed to fetch current user:\(error)"
                    print(self.errorMessage)
                    return
                } else {
                    for document in snapshot!.documents {
                
                        let postId = document.documentID
                        //print("getting data...")
                        let data = document.data()
                        //print(data)
                        let uid = data["uid"] as? String ?? ""
                        let title = data["title"] as? String ?? ""
                        let description = data["description"] as? String ?? ""
                        let postImageUrl = data["postImageUrl"] as? String ?? ""
                        let username = data["username"] as? String ?? ""
                        
                        let newPost = Post(postId: postId,username: username, title: title, description: description, uid: uid, postImageUrl: postImageUrl)
                        
                        self.posts.append(newPost)
                        //print(self.posts)
                    }
                }
                
            }
    }
}
