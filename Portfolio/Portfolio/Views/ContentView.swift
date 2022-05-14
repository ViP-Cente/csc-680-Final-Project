//
//  ContentView.swift
//  Portfolio
//
//  Created by JPL-ST-SPRING2021 on 3/31/22.
//

import SwiftUI


struct ContentView: View {
    
    @ObservedObject private var postsModel = PostsModel()
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State var signOutProcessing = false
    @State var userModel: UserProfileViewModel?
    
    var body: some View {
        
            NavigationView {
                List{
                    ForEach(postsModel.posts){ post in
                        PostRow(post: post)
                    }
                }
                .navigationTitle("App Title")
                
                .toolbar {
                    ToolbarItem(placement:.navigationBarTrailing) {
                        if signOutProcessing {
                            ProgressView()
                        } else {
                            HStack{
                                Button{
                                    viewRouter.currentPage = .createPostPage
                                }label: {
                                    Label("Create Post", systemImage: "plus.rectangle.fill" )
                                }
                                Button{
                                     viewRouter.currentPage = .profile
                                }label: {
                                      Label("Profile", systemImage: "person.crop.circle.fill" )
                                }

                                Button("Sign Out") {
                                    signOutUser()
                                }
                            }
                            
                        }
                    }
                }
                .accentColor(.red)
        }}
    
    func signOutUser() {
        signOutProcessing = true
        let firebaseAuth = FirebaseManager.shared.auth
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
            signOutProcessing = false

                    
            }

            }
       

        }
    


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(.light)
        }
    }
}
