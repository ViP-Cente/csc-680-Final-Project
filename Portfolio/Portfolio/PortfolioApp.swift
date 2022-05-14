//
//  PortfolioApp.swift
//  Portfolio
//
//  Created by Majot and Vicente on 3/31/22.
//

import SwiftUI


@main
struct PortfolioApp: App {
    @StateObject var viewRouter = ViewRouter()
        
        var body: some Scene {
            WindowGroup {
                MotherView().environmentObject(viewRouter)
            }
        }
    
}


