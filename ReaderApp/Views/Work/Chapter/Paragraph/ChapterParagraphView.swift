//
//  ChapterParagraphView.swift
//  Reader (iOS)
//
//  Created by Natasha Martinez on 11/26/22.
//

import AO3Scraper
import SwiftUI

struct ChapterParagraphView: View {
    
    let chapterParagraph: ChapterParagraph
    let fontType: Font
    
    let placeholderImageSize: Double = 300.0
    
    var body: some View {
        if let text = chapterParagraph.text {
            text.convertToView()
                .font(fontType)
        } else if let imageURL = chapterParagraph.imageURL {
            AsyncImage(url: imageURL) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .accessibilityValue(chapterParagraph.altText ?? "")
            } placeholder: {
                Rectangle()
                    .frame(width: placeholderImageSize, height: placeholderImageSize, alignment: .center)
                    .foregroundColor(.pink)
            }
        }
    }
}
