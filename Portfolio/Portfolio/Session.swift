//
//  Session.swift
//  Portfolio
//
//  Created by JPL-ST-SPRING2021 on 4/7/22.
//

import SwiftUI
import Foundation
import Firebase
import Combine

struct User{
    var userId: String
    var username: String?
    var email: String?
    var photoURL: URL?
    
    static let `default` = Self(
        userId: "randomId01",
        username: "Vicente",
        email: "vpericone@mail.sfsu.edu",
        photoURL: nil
    )
    
    init(userId: String, username: String?, email: String?, photoURL: URL?){
        self.userId = userId
        self.username = username
        self.email = email
        self.photoURL = photoURL
    }
}

class SessionStore: ObservableObject{
    var didChange = PassthroughSubject<SessionStore, Never>()
    var isLoggedIn = false { didSet {self.didChange.send(self) }}
    var session: User? { didSet { self.didChange.send(self) }}
    var handle: AuthStateDidChangeListenerHandle?
    
    init (session: User? = nil){
        self.session = session
    }
    
    func listen() {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                print ("Got user \(user)")
                self.isLoggedIn = true
                self.session = User(
                    userId: user.uid,
                    username: user.displayName,
                    email: user.email,
                    photoURL: user.photoURL
                )
            } else{
                self.isLoggedIn = false
                self.session = nil
            }
        }
    }
    
    func signUp(email:String, password: String, handler: @escaping AuthDataResultCallback){
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }
    
    func signIn(email: String, password: String, handler: @escaping AuthDataResultCallback){
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
    
    func signOut() -> Bool {
        do {
            try Auth.auth().signOut()
            return true
        } catch{
            return false
        }
    }
    
    func unbind() {
        if let handle = handle{
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}
