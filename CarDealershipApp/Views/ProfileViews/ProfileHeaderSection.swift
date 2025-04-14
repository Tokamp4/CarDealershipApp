//
//  ProfileHeaderSection.swift
//  CarDealershipApp
//
//  Created by Adril Kemyem on 2025-04-13.
//

import SwiftUI
import PhotosUI

struct ProfileHeaderSection: View {
    var profileImage: UIImage?
    var urlString: String?
    @Binding var selectedItem: PhotosPickerItem?
    var displayName: String
    var onUpload: (UIImage) -> Void

    var body: some View {
        VStack(spacing: 12) {
            if let image = profileImage {
                Image(uiImage: image)
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 120, height: 120)
                    .overlay(Circle().stroke(Color.gray, lineWidth: 2))
            } else if let urlString = urlString, let url = URL(string: urlString) {
                AsyncImage(url: url) { phase in
                    if let image = phase.image {
                        image.resizable()
                    } else if phase.error != nil {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .foregroundColor(.gray)
                    } else {
                        ProgressView()
                    }
                }
                .clipShape(Circle())
                .frame(width: 120, height: 120)
                .overlay(Circle().stroke(Color.gray, lineWidth: 2))
            } else {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .foregroundColor(.gray)
            }

            PhotosPicker(selection: $selectedItem, matching: .images) {
                Text("Change Profile Picture")
                    .font(.subheadline)
                    .foregroundColor(.blue)
            }
            .onChange(of: selectedItem) {
                Task {
                    if let data = try? await selectedItem?.loadTransferable(type: Data.self),
                       let uiImage = UIImage(data: data) {
                        onUpload(uiImage)
                    }
                }
            }

            Text("Main Account")
                .font(.title2)
                .fontWeight(.bold)

            if !displayName.isEmpty {
                Text(displayName)
                    .font(.title2)
                    .foregroundColor(.gray)
            }
        }
        .frame(maxWidth: .infinity)
        .multilineTextAlignment(.center)
    }
}
