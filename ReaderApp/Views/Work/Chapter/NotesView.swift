//
//  NotesView.swift
//  Reader (iOS)
//
//  Created by Natasha Martinez on 11/29/22.
//

import AO3Scraper
import SwiftUI

struct NotesView: View {
    let notes: [ChapterParagraph]
    
    var body: some View {
        Text("Notes:")
            .frame(maxWidth: .infinity, alignment: .leading)
            .minimumScaleFactor(0.01)
        
        ParagraphListView(items: notes, fontType: .callout)
            .foregroundColor(.systemBlack)
    }
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView(notes: [])
    }
}
