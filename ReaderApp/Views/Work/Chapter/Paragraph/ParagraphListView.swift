//
//  ParagraphListView.swift
//  Reader (iOS)
//
//  Created by Natasha Martinez on 11/28/22.
//

import AO3Scraper
import SwiftUI

struct ParagraphListView: View {
    
    let items: [ChapterParagraph]
    let fontType: Font
    var body: some View {
        VStack {
            ForEach(items) { paragraph in
                ChapterParagraphView(chapterParagraph: paragraph, fontType: fontType)
            }
        }
    }
}

struct ParagraphListView_Previews: PreviewProvider {
    static var previews: some View {
        ParagraphListView(items: [], fontType: .body)
    }
}
