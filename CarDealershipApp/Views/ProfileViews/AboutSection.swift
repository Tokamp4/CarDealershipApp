//
//  AboutSection.swift
//  CarDealershipApp
//
//  Created by Adril Kemyem on 2025-04-13.
//

import SwiftUI

struct AboutSection: View {
    @State private var isEditing = false
    @State private var editedBio: String
    var bio: String
    var onSave: (String) -> Void

    init(bio: String, onSave: @escaping (String) -> Void) {
        self.bio = bio
        self._editedBio = State(initialValue: bio)
        self.onSave = onSave
    }

    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text("About")
                    .font(.headline)
                    .foregroundColor(.gray)
                Spacer()
                Button(action: {
                    isEditing.toggle()
                    editedBio = bio
                }) {
                    Text(isEditing ? "Cancel" : "Edit")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
            }

            if isEditing {
                TextEditor(text: $editedBio)
                    .frame(height: 100)
                    .padding(8)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)

                Button("Save") {
                    onSave(editedBio)
                    isEditing = false
                }
                .padding(.top, 4)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
            } else {
                Text(bio.isEmpty ? "No bio added yet." : bio)
                    .font(.body)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(maxWidth: .infinity)
    }
}
