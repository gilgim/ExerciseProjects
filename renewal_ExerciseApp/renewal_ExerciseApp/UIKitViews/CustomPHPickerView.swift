//
//  CustomPHPickerView.swift
//  renewal_ExerciseApp
//
//  Created by KimWooJin on 2022/12/07.
//

import Foundation
import SwiftUI
import PhotosUI

//  For Using PHPickerViewController, I made it
struct CustomPHPickerView: UIViewControllerRepresentable {
    typealias UIViewControllerType = PHPickerViewController
    @Binding var selectImage: UIImage?
    @Binding var imageData: Data?
    @Binding var closure: (() ->())?
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        //  Number of user select photo
        configuration.selectionLimit = 1
        //  Limit data type
        configuration.filter = .images
        //  Setting PHPickerViewController.
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(selectImage: $selectImage, imageData: $imageData, closure: $closure)
    }
    class Coordinator: PHPickerViewControllerDelegate {
        @Binding var selectImage: UIImage?
        @Binding var closure: (()->())?
        @Binding var imageData: Data?
        
        init(selectImage: Binding<UIImage?>, imageData: Binding<Data?>, closure: Binding<(()->())?>) {
            self._selectImage = selectImage
            self._imageData = imageData
            self._closure = closure
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            let itemProvider = results.first?.itemProvider
            let semaphore = DispatchSemaphore(value: 0)
            
            DispatchQueue.global(qos: .userInteractive).async {
                if let itemProvider = itemProvider,itemProvider.canLoadObject(ofClass: UIImage.self) {
                    itemProvider.loadObject(ofClass: UIImage.self) { image, _ in
                        DispatchQueue.main.async {
                            if let imageData = (image as? UIImage)?.jpegData(compressionQuality: 0.3) {
                                self.imageData = imageData
                                self.selectImage = UIImage(data: imageData)
                            }
                            else {
                                self.selectImage = image as? UIImage
                            }
                        }
                        actionClosure(action: self.closure)
                        semaphore.signal()
                    }
                    semaphore.wait()
                }
            }
        }
    }
}
