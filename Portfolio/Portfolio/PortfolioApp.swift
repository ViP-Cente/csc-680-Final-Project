//
//  PortfolioApp.swift
//  Portfolio
//
//  Created by JPL-ST-SPRING2021 on 3/31/22.
//

import SwiftUI
import Firebase

@main
struct PortfolioApp: App {
    @StateObject var viewRouter = ViewRouter()
        
        init() {
            FirebaseApp.configure()
        }
        
        var body: some Scene {
            WindowGroup {
                MotherView().environmentObject(viewRouter)
            }
        }}
