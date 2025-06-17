//
//  ProfilePic.swift
//  ReaderApp
//
//  Created by Natasha Martinez on 5/7/25.
//

import SwiftUI

struct ProfilePic: View {
    
    let coverImage: URL?
    
    var body: some View {
        if let coverImage = coverImage {
            AsyncImage(url: coverImage) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .accessibilityValue("profile picture")
                    .overlay(
                        Rectangle()
                            .stroke(.highlight, lineWidth: 2)
                    )
            } placeholder: {
                noProfilePicView()
            }
        } else {
            noProfilePicView()
        }
    }
    
    func noProfilePicView() -> some View {
        HStack {
            if coverImage == nil {
                Rectangle()
                    .foregroundColor(.textCustom)
                    .overlay {
                        Image("noProfilePic")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .accessibilityValue("profile picture")
                    }
                    .overlay(
                        Rectangle()
                            .stroke(.highlight, lineWidth: 2)
                    )
            } else {
                Rectangle()
                    .foregroundColor(.backgroundCustom)
            }
        }
    }
}

#Preview {
    ProfilePic(coverImage: nil)
}
