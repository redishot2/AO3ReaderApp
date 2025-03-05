//
//  ContentView.swift
//  ReaderApp
//
//  Created by Natasha Martinez on 3/2/25.
//

import SwiftUI
import AO3Scraper

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                FeedView(title: "Harry Potter - J. K. Rowling")
            }
        }
    }
}

#Preview {
    ContentView()
}
