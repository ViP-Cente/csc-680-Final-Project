//
//  ContentView.swift
//  Portfolio
//
//  Created by JPL-ST-SPRING2021 on 3/31/22.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
        
        @State var signOutProcessing = false
        
        var body: some View {
            NavigationView {
                Text("HomeView")
                    .navigationTitle("App Title")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            if signOutProcessing {
                                ProgressView()
                            } else {
                                Button("Sign Out") {
                                    signOutUser()
                                }
                            }
                        }
                    }
            }
        }
        
        func signOutUser() {
            signOutProcessing = true
            let firebaseAuth = Auth.auth()
            do {
              try firebaseAuth.signOut()
            } catch let signOutError as NSError {
              print("Error signing out: %@", signOutError)
                signOutProcessing = false
            }
            withAnimation {
                viewRouter.currentPage = .signInPage
            }
        }
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
