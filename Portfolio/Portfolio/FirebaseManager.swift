//
//  FirebaseManager.swift
//  Portfolio
//
//  Created by Manjot Singh on 5/6/22.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore

class FirebaseManager: NSObject {
    
    let auth: Auth
    let storage: Storage
    let firestore: Firestore
    
    static let shared = FirebaseManager()
    
    override init() {
        FirebaseApp.configure()
        
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        self.firestore = Firestore.firestore()
        
        super.init()
    }
    
    public func imageToStorage(id: String, imageShowing: UIImage?, urlHandler: @escaping (String, URL) -> Void){
        //        print("IM here")
        //let filename = UUID().uuidString
        //        print("IM here")
        
        //print("IM here2")
        let ref = FirebaseManager.shared.storage.reference(withPath: id)
        //print("IM here3")
        
        var img = imageShowing
        if img == nil{
            img = UIImage(named: "default-placeholder")
        }
        
        guard let imageData = img?.jpegData(compressionQuality: 0.5) else {
            print("imagedata not acccessed.")
            
            return
        }
        
        ref.putData(imageData, metadata: nil){ metadata, err in
            if let err = err {
                print("Unable to upload image to the storage -> \(err)")
                return
            }
            ref.downloadURL{ url, err in
                if let err = err {
                    print("Failed to retreive downloadURL -> \(err)")
                    return
                }
                print("Successfully stored image with url -> \(url?.absoluteString ?? "")")
                
                guard let url = url else {
                    return
                }
                
                urlHandler(id, url)
                
                return
            }
        }
        
    }
}
