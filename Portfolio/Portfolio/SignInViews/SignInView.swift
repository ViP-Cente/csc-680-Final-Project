//
//  SignInView.swift
//  Portfolio
//
//  Created by JPL-ST-SPRING2021 on 4/8/22.
//
import SwiftUI
import Foundation

struct SignInView : View {
    @State var email: String = ""
    @State var password: String = ""
    @State var loading = false
    @State var error = false
    
    @EnvironmentObject var session: SessionStore
    
    func signIn () {
        loading = true
        error = false
        session.signIn(email: email, password: password) { (result, error) in
            self.loading = false
            if error != nil{
                //print(error)
                self.error = true
            } else {
                //Try with "test@mail.com password" when testing for success
                self.email = ""
                self.password = ""
                print("Completed Sign-In")
            }
        }
    }
    
    var body: some View{
        VStack{
            TextField("Email Address", text: $email)
            SecureField("Password", text: $password)
            if(error) {
                Text("ahh crap error ")
            }
            Button(action: signIn){
                Text("Sign in")
            }
        }
    }
}
