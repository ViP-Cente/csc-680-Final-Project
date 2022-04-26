//
//  PhotoPicker.swift
//  Portfolio
//
//  Created by Manjot Singh on 4/24/22.
//

import SwiftUI

struct PhotoPicker: UIViewControllerRepresentable {
    
    @Binding var imageShowing: UIImage?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(photoPicker: self)
    }
    
    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        let photoPicker: PhotoPicker
        
        init(photoPicker: PhotoPicker) {
            self.photoPicker = photoPicker
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.editedImage] as? UIImage {
                guard let data = image.jpegData(compressionQuality: 0.9), let compressedImage = UIImage(data: data) else {
                          return
                      }
                photoPicker.imageShowing = compressedImage
            } else {
                photoPicker.imageShowing = UIImage(named: "default-placeholder")!
            }
            picker.dismiss(animated: true)
        }
    }
    
}
