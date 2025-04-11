////
////  ImageUploader.swift
////  CarDealershipApp
////
////  Created by Nizmee Wuvais on 2025-04-08.
////

import UIKit
import FirebaseStorage

class ImageUploader {
    static func uploadImage(_ image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(.failure(NSError(domain: "ImageError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to convert image to data."])))
            return
        }

        let filename = UUID().uuidString + ".jpg"
        let storageRef = Storage.storage().reference().child("car_images/\(filename)")

        storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            storageRef.downloadURL { url, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let downloadURL = url else {
                    completion(.failure(NSError(domain: "URLFetchError", code: -2, userInfo: [NSLocalizedDescriptionKey: "Failed to retrieve download URL."])))
                    return
                }

                completion(.success(downloadURL.absoluteString))
            }
        }
    }
}
