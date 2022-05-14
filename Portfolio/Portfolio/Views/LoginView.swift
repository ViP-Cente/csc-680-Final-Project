//
//  SignInView.swift
//  Portfolio
//
//  Created by Vicente Pericone on 4/8/22.
//
import SwiftUI
import Foundation




struct LoginView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State var email = ""
    @State var password = ""
    
    @State var loginProcessing = false
    @State var loginErrorMessage = ""
    
    var body: some View {
        VStack(spacing: 15) {
            //LogoView()
            Spacer()
            LoginCredentialFields(email: $email, password: $password)
            Button(action: {
                loginUser(userEmail: email, userPassword: password)
            }) {
                Text("Log In")
                    .bold()
                    .frame(width: 360, height: 50)
                    .background(.thinMaterial)
                    .cornerRadius(10)
            }
                .disabled(!loginProcessing && !email.isEmpty && !password.isEmpty ? false : true)
            if loginProcessing {
                ProgressView()
            }
            if !loginErrorMessage.isEmpty {
                Text("Failed creating account: \(loginErrorMessage)")
                    .foregroundColor(.red)
            }
            Spacer()
            HStack {
                Text("Don't have an account?")
                Button(action: {
                    viewRouter.currentPage = .signUpPage
                }) {
                    Text("Sign Up").foregroundColor(.red)
                }
            }
                .opacity(0.9)
        }
            .padding()
    }
    
    func loginUser(userEmail: String, userPassword: String) {
        
        loginProcessing = true
        
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password) { authResult, error in
            
            guard error == nil else {
                loginProcessing = false
                loginErrorMessage = error!.localizedDescription
                return
            }
            switch authResult {
            case .none:
                print("Could not sign in user.")
                loginProcessing = false
            case .some(_):
                print("User signed in")
                loginProcessing = true
                withAnimation {
                    viewRouter.currentPage = .homePage
                }
            }
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

