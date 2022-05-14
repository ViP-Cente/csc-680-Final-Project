//
//  PostRow.swift
//  Portfolio
//
//  Created by Vicente Pericone on 5/12/22.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct PostRow: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    var post: Post
    
    var body: some View {
        VStack {
            
            Text("Title: \(post.title)")
                .padding()
                .font(.system(size: 20))
            WebImage(url: URL(string: post.postImageUrl ))
                .resizable().scaledToFill()
                .frame(width: 200, height: 200).cornerRadius(40)
            Text("About: \(post.description )")
                .font(.system(size: 20))
            Text("Username: \(post.username )")
                .font(.system(size: 20))
            
            
        }
    }
}
