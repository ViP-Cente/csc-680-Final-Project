//
//  CreatePost.swift
//  Portfolio
//
//  Created by Manjot Singh on 4/24/22.
//

import SwiftUI


struct CreatePostView: View {
    
    @ObservedObject private var userModel = UserProfileViewModel()
    @EnvironmentObject var viewRouter: ViewRouter
    @State private var isShowingPhotoPicker = false;
    
    @State var title: String = ""
    @State var description: String = ""
    
    @State var createProcessing = false
    @State var createErrorMessage = ""
    @State var createSuccessMessage = ""
    
    @State var imageShowing: UIImage?
    @State var imageUploadStatus: String?
    
    var body: some View {
        VStack{
            Button{
                viewRouter.currentPage = .homePage
            }label: {
                Label("Back", systemImage: "arrow.left" )
            }
            Text("Create Post")
                .fontWeight(.bold)
                .font(.system(.largeTitle, design: .rounded ))
                .foregroundColor(.gray)
            
            
            CreatePostFields(title: $title, description: $description)
            Group{
                Button{
                    isShowingPhotoPicker.toggle()
                } label: {
                    VStack{

                        if let image = self.imageShowing {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 256, height: 256)

                        } else {
                            Image(uiImage: UIImage(named: "default-placeholder")!)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(.all)

                                .frame(width: 256, height: 256)
                        }
                    }
                }
            }
            
            Spacer()
            Button(action: {
                createPost(postTitle: title, postDescription: description)
            }) {
                Text("Post")
                    .bold()
                    .frame(width: 360, height: 50)
                    .background(.purple)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(!createProcessing && !title.isEmpty && !description.isEmpty  ? false : true)
            if createProcessing {
                ProgressView()
            }
            
            if !createErrorMessage.isEmpty {
                Text("Failed creating account: \(createErrorMessage)")
                    .foregroundColor(.red)
            }
            if !createSuccessMessage.isEmpty {
                Text("\(createSuccessMessage)")
                    .foregroundColor(.green)
            }
            
            VStack {
                if let status = self.imageUploadStatus {
                    Text("Status: \(status)")
                }
                
            }
            
        }.opacity(0.9).sheet(isPresented: $isShowingPhotoPicker , content: {

            PhotoPicker(imageShowing: $imageShowing)
        })
        
    }
    
    func createPost(postTitle: String, postDescription: String) {
        
        createProcessing = true
        
//        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
//            return
//        }
        guard let username = userModel.loggedUser?.username else{
            return
        }
        guard let uid = userModel.loggedUser?.uid else{
            return
        }
        let postData = ["title": self.title, "description": self.description,"uid": uid, "username": username, "postImageUrl": "needs image url"]
        
        //Creating the document in the database
        //in storePostInformation(), we will update the imageURL
        let postId = FirebaseManager.shared.firestore.collection("posts")
            .addDocument(data: postData) { err in
                if let err = err{
                    print(err)
                    self.createErrorMessage = "\(err)"
                    return
                }
            }
        print("First postId = \(postId)")
        FirebaseManager.shared.imageToStorage(id: postId.documentID, imageShowing: imageShowing, urlHandler: storePostInformation(id:imageUrl:))
        
    }
    
    private func storePostInformation(id: String, imageUrl: URL){
//        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
//            return
//        }
        guard let username = userModel.loggedUser?.username else{
            return
        }
        guard let uid = userModel.loggedUser?.uid else{
            return
        }
        
        print("getting userModel...")
        print(userModel.loggedUser?.username ?? "no username")
        let postData = ["title": self.title, "description": self.description,"uid": uid, "username": username, "postImageUrl": imageUrl.absoluteString]
        FirebaseManager.shared.firestore.collection("posts").document(id).setData(postData){ err in
                if let err = err{
                    print(err)
                    self.createErrorMessage = "\(err)"
                    return
                }
                
                print("Successfully Stored post Information")
                self.createSuccessMessage = "Successfully Created Post: \(self.title)"
                withAnimation{
                    viewRouter.currentPage = .homePage
                }
            }
        
    }
}

struct CreatePost_Previews: PreviewProvider {
    static var previews: some View {
        CreatePostView()
    }
}
