//
//  FirebaseManager.swift
//  Portfolio
//
//  Created by JPL-ST-SPRING2021 on 5/6/22.
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
    
    public func imageToStorage(imageShowing: UIImage?, urlHandler: @escaping (URL) -> Void){
        //        print("IM here")
        //let filename = UUID().uuidString
        //        print("IM here")
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            print("User not accessed.")
            return
        }
        //print("IM here2")
        let ref = FirebaseManager.shared.storage.reference(withPath: uid)
        //print("IM here3")
        
        var userImg = imageShowing
        if userImg == nil{
            userImg = UIImage(named: "default-placeholder")
        }
        
        guard let imageData = userImg?.jpegData(compressionQuality: 0.5) else {
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
                
                urlHandler(url)
                
                return
            }
        }
        
    }
}
