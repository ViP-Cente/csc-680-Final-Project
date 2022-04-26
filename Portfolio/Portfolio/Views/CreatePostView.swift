//
//  CreatePost.swift
//  Portfolio
//
//  Created by Manjot Singh on 4/24/22.
//

import SwiftUI
import Firebase

class FirebaseManager: NSObject {
    
    let storage: Storage
    
    static let shared = FirebaseManager()
    
    override init() {
        FirebaseApp.configure()
        self.storage = Storage.storage()
        
        super.init()
    }
}


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
                //imageToStorage()
            }
            VStack {
                if let status = self.imageUploadStatus {
                    Text("Status: \(status)")
                }
            }
            Spacer()
            Button("Back"){
                viewRouter.currentPage = .signInPage
            }
        }
        .sheet(isPresented: $isShowingPhotoPicker , content: {
            PhotoPicker(imageShowing: $imageShowing)
        })
    }
    
//    private func imageToStorage(){
//        print("IM here")
//        let filename = UUID().uuidString
//        print("IM here")
//        guard let uid = Auth.auth().currentUser?.uid else {
//            print("User not accessed.")
//            return
//        }
//        print("IM here2")
//        let ref = FirebaseManager.shared.storage.reference(withPath: filename)
//        print("IM here3")
//        guard let imageData = self.imageShowing?.jpegData(compressionQuality: 0.5) else {
//            print("imagedata not acccessed.")
//        return
//        }
//        ref.putData(imageData, metadata: nil){ metadata, err in
//            if let err = err {
//                print("Unable to upload image to the storage -> \(err)")
//                return
//            }
//        ref.downloadURL{ url, err in
//            if let err = err {
//                print("Failed to retreive downloadURL -> \(err)")
//                return
//            }
//            print("Successfully stored image with url -> \(url?.absoluteString ?? "")")
//        }
//    }
//
//    }
    
}

struct CreatePost_Previews: PreviewProvider {
    static var previews: some View {
        CreatePostView()
    }
}
