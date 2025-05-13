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
                            .stroke(.set1PinkDark, lineWidth: 2)
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
                    .foregroundColor(.systemWhite)
                    .overlay {
                        Image("noProfilePic")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .accessibilityValue("profile picture")
                    }
                    .overlay(
                        Rectangle()
                            .stroke(.set1PinkDark, lineWidth: 2)
                    )
            } else {
                Rectangle()
                    .foregroundColor(.set1PinkDark)
            }
        }
    }
}

#Preview {
    ProfilePic(coverImage: nil)
}
