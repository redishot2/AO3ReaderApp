//
//  ContentView.swift
//  ReaderApp
//
//  Created by Natasha Martinez on 3/2/25.
//

import SwiftUI
import AO3Scraper

struct ContentView: View {
    @State private var work: Work? = nil
    private let chapterNetworking = ChapterNetworking()
    
    private enum Constants {
        static let workWithPic = "34500952"
        static let workNoPic = "23556700"
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if let work = work {
                    WorkInformationView(work: work)
                } else {
                    Text("Loading...")
                }
            }
            .task {
                work = await chapterNetworking.fetch(work: Constants.workWithPic)
            }
        }
    }
}

#Preview {
    ContentView()
}
