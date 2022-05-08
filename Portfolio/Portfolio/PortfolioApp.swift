//
//  PortfolioApp.swift
//  Portfolio
//
//  Created by JPL-ST-SPRING2021 on 3/31/22.
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


