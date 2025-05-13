//
//  ChapterView.swift
//  Reader (iOS)
//
//  Created by Natasha Martinez on 11/26/22.
//

import AO3Scraper
import SwiftUI

struct ChapterView: View {
    
    @State private var showPostNotes: Bool = false
    @State var chapter: Chapter
    
    var body: some View {
        VStack {
            // Pre Notes
            if chapter.preNotes.count > 0 {
                NotesView(notes: chapter.preNotes)
                
                Divider()
            }
            
            Spacer()
            Spacer()
            
            // Content
            ParagraphListView(items: chapter.paragraphs, fontType: .body)
            
            Spacer()
            Spacer()
            
            // Post Chapter Notes
            if chapter.postNotes.count > 0 {
                Divider()
                    
                // Post Notes
                NotesView(notes: chapter.postNotes)
            }
        }
    }
}
