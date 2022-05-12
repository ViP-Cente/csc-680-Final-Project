//
//  UserProfileView.swift
//  Portfolio
//
//  Created by Manjot Hundal on 5/11/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct UserProfileView: View {
    
    @ObservedObject private var vm = UserProfileViewModel()
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        NavigationView{
            VStack{
                WebImage(url: URL(string: vm.loggedUser?.profileImageUrl ?? ""))
                    .resizable().scaledToFill()
                    .frame(width: 200, height: 200).cornerRadius(40)
                Text("Email: \(vm.loggedUser?.email ?? "")")
                    .padding()
                    .font(.system(size: 20))
                Text("Username: \(vm.loggedUser?.username ?? "")")
                    .font(.system(size: 20))
                .navigationBarTitle(Text("Profile"))
                .navigationBarItems(leading: Button(action: {viewRouter.currentPage = .homePage}) {
                    HStack {
                        Image(systemName: "arrow.left")
                        Text("Back")
                    }
                })
            }
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}

