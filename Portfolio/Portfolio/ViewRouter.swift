//
//  ViewRouter.swift
//  Portfolio
//
//  Created by Vicente Pericone on 4/20/22.
//

import SwiftUI

class ViewRouter: ObservableObject {
    
    @Published var currentPage: Page = .loginPage
    
}

enum Page {
    case signUpPage
    case loginPage
    case homePage
    case createPostPage
    case profile
}
