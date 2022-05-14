//
//  CreatePostView.swift
//  Portfolio
//
//  Created by Vicente Pericone on 5/11/22.
//

import Foundation
import SwiftUI

struct CreatePostFields: View {
    
    @Binding var title: String
    @Binding var description: String
    
    var body: some View {
        VStack {
            TextField("Title", text: $title)
                .padding()
                .background(.thinMaterial)
                .cornerRadius(10)
                .textInputAutocapitalization(.never)
            TextField("Description", text: $description)
                .padding()
                .background(.thinMaterial)
                .cornerRadius(10)
                .textInputAutocapitalization(.never)
            
            
            
        }
    }
}
