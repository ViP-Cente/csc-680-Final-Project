//
//  SignUpView.swift
//  Portfolio
//
//  Created by Vicente Pericone on 4/8/22.
//

import Foundation
import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State var username = ""
    @State var email = ""
    @State var password = ""
    @State var passwordConfirmation = ""
    
    @State var signUpProcessing = false
    @State var signUpErrorMessage = ""
    @State var signUpSuccessMessage = ""
    
    @State private var isShowingPhotoPicker = false;
    @State var imageShowing: UIImage?
    @State var imageUploadStatus: String?
    
    var body: some View {
        VStack(spacing: 15) {
            //LogoView()
            Spacer()
            Button {
                isShowingPhotoPicker.toggle()
            } label: {
                VStack {
                    if let image = self.imageShowing {
                        Image(uiImage: image)
                            .resizable().scaledToFill()
                            .frame(width: 128, height: 128).cornerRadius(64)
                    } else {
                        Image(uiImage: UIImage(named: "default-placeholder")!)
                            .resizable().scaledToFill()
                            .frame(width: 128, height: 128).cornerRadius(64)
                    }
                }
            }
            SignUpCredentialFields(username: $username, email: $email, password: $password, passwordConfirmation: $passwordConfirmation)
            Button(action: {
                signUpUser(userEmail: email, userPassword: password)
            }) {
                Text("Sign Up")
                    .bold()
                    .frame(width: 360, height: 50)
                    .background(.thinMaterial)
                    .cornerRadius(10)
            }
            .disabled(!signUpProcessing && !email.isEmpty && !password.isEmpty && !passwordConfirmation.isEmpty && password == passwordConfirmation ? false : true)
            if signUpProcessing {
                ProgressView()
            }
            
            if !signUpErrorMessage.isEmpty {
                Text("Failed creating account: \(signUpErrorMessage)")
                    .foregroundColor(.red)
            }
            if !signUpSuccessMessage.isEmpty {
                Text("\(signUpSuccessMessage)")
                    .foregroundColor(.green)
            }
            
            Spacer()
            HStack {
                Text("Already have an account?")
                Button(action: {
                    viewRouter.currentPage = .loginPage
                }) {
                    Text("Log In").foregroundColor(.red)
                }
            }
            .opacity(0.9).sheet(isPresented: $isShowingPhotoPicker , content: {
                PhotoPicker(imageShowing: $imageShowing)
            })
        }
        .padding()
    }
    
    func signUpUser(userEmail: String, userPassword: String) {
        
        signUpProcessing = true
        
        FirebaseManager.shared.auth.createUser(withEmail: userEmail, password: userPassword) { result, error in
            guard error == nil else {
                signUpErrorMessage = error!.localizedDescription
                print(signUpErrorMessage)
                signUpProcessing = false
                return
            }
            
            guard let uid = result?.user.uid else{
                return
            }
            
            print("Successfully Created User: \(uid)")
            
            
            FirebaseManager.shared.imageToStorage(id: uid, imageShowing: imageShowing, urlHandler: storeUserInformation(id:imageProfileUrl:))
            
        }
        
    }
    private func storeUserInformation(id: String, imageProfileUrl: URL){
        let userData = ["username": self.username, "email": self.email, "uid": id, "profileImageUrl": imageProfileUrl.absoluteString]
        FirebaseManager.shared.firestore.collection("users")
            .document(id).setData(userData) { err in
                if let err = err{
                    print(err)
                    self.signUpErrorMessage = "\(err)"
                    return
                }
                
                print("Successfully Stored user Information")
                self.signUpSuccessMessage = "Successfully Created User: \(self.email)"
                withAnimation{
                    viewRouter.currentPage = .homePage
                }
            }
    }
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

//struct LogoView: View {
//    var body: some View {
//        Image("Logo")
//            .resizable()
//            .aspectRatio(contentMode: .fit)
//            .frame(width: 300, height: 150)
//            .padding(.top, 70)
//    }
//}




