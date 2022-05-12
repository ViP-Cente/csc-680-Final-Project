//
//  MotherView.swift
//  Portfolio
//
//  Created by JPL-ST-SPRING2021 on 4/20/22.
//

import SwiftUI

struct MotherView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        switch viewRouter.currentPage {
        case .signUpPage:
            SignUpView()
        case .loginPage:
            LoginView()
        case .homePage:
            ContentView()
        case .createPostPage:
            CreatePostView()
        case .profile:
            UserProfileView()
        }
    }
}

struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView().environmentObject(ViewRouter())
    }
}
