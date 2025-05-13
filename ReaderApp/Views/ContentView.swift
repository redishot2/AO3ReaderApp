//
//  ContentView.swift
//  ReaderApp
//
//  Created by Natasha Martinez on 3/2/25.
//

import SwiftUI
import AO3Scraper

struct ContentView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                FeedView(title: "+Anima (Manga)")
            }
        }
        .accentColor(.set1PinkDark)
        .navigationTitle("Home")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Label("Back", systemImage: "arrow.left.circle")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
