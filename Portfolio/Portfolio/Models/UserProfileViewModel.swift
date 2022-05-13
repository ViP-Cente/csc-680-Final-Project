//
//  UserProfileViewModel.swift
//  Portfolio
//
//  Created by Manjot Hundal on 5/11/22.
//
import SwiftUI

struct LoggedInProfile {
    let uid, email,username, profileImageUrl: String
}

class UserProfileViewModel: ObservableObject {
    
    @Published var errorMessage = ""
    @Published var loggedUser: LoggedInProfile?
    
    init() {
        fetchCurrentUser()
    }
    
    private func fetchCurrentUser(){
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            self.errorMessage = "Could not find firebase uid"
            return
        }

        FirebaseManager.shared.firestore.collection("users")
            .document(uid).getDocument { snapshot, error in
                if let error = error {
                    self.errorMessage = "Failed to fetch current user:\(error)"
                    return
                }
                
                guard let data = snapshot?.data() else {
                    self.errorMessage = "No data found"
                    return
                }
                
                let uid = data["uid"] as? String ?? ""
                let email = data["email"] as? String ?? ""
                let username = data["username"] as? String ?? ""
                let profileImageUrl = data["profileImageUrl"] as? String ?? ""
                self.loggedUser = LoggedInProfile(uid: uid, email: email,username: username, profileImageUrl: profileImageUrl)
                print(self.loggedUser?.username)
            }
    }
}
