//
//  ContentView.swift
//  Portfolio
//
//  Created by JPL-ST-SPRING2021 on 3/31/22.
//

import SwiftUI


struct ContentView: View {
    
    @EnvironmentObject var session: SessionStore
    
    func getUser(){
        session.listen()
    }
    
    var body: some View {
        Group{
            if (session.session != nil) {
                Text("Hello User!")
            } else {
                Text("Auth Screen Here")
            }
        }.onAppear(perform: getUser)
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(SessionStore())
    }
}
#endif
