//
//  CreatePost.swift
//  Portfolio
//
//  Created by Manjot Singh on 4/24/22.
//

import SwiftUI


struct CreatePostView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @State private var isShowingPhotoPicker = false;
    @State var imageShowing: UIImage?
    @State var imageUploadStatus: String?
    
    var body: some View {
        VStack{
            Text("Create Post")
                .fontWeight(.bold)
                .font(.system(.largeTitle, design: .rounded ))
                .foregroundColor(.gray)
            Button {
                isShowingPhotoPicker.toggle()
            } label: {
                VStack {
                    if let image = self.imageShowing {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.all)
                    } else {
                        Image(uiImage: UIImage(named: "default-placeholder")!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.all)
                    }
                }
            }
            Button("Post") {
                //FirebaseManager.shared.imageToStorage(imageShowing: imageShowing)
            }
            VStack {
                if let status = self.imageUploadStatus {
                    Text("Status: \(status)")
                }
            }
            Spacer()
            Button("Back"){
                viewRouter.currentPage = .homePage
            }
        }
        .sheet(isPresented: $isShowingPhotoPicker , content: {
            PhotoPicker(imageShowing: $imageShowing)
        })
    }
    
    
}

struct CreatePost_Previews: PreviewProvider {
    static var previews: some View {
        CreatePostView()
    }
}
