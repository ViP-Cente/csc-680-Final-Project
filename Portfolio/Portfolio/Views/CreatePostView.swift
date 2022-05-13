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
        NavigationView{
            VStack{
//                Text("Create Post")
//                    .fontWeight(.bold)
//                    .font(.system(.largeTitle, design: .rounded ))
//                    .foregroundColor(.secondary)
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
                    viewRouter.currentPage = .homePage
                }.foregroundColor(.red).font(.title).background(.bar)
                VStack {
                    if let status = self.imageUploadStatus {
                        Text("Status: \(status)")
                    }
                }
                Spacer()
                    .navigationTitle("Create Post")
                    .navigationBarItems(leading: Button(action: {viewRouter.currentPage = .homePage}) {
                        HStack {
                            Image(systemName: "arrow.left")
                            Text("Back")
                        }
                    })
                    .accentColor(.red)
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
