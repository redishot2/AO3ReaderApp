//
//  CategoriesView.swift
//  ReaderApp
//
//  Created by Natasha Martinez on 6/17/25.
//

import AO3Scraper
import SwiftUI

struct CategoriesView: View {
    let title: String
    
    @StateObject var categoriesViewModel = CategoriesViewModel()
    @State private var searchText = ""
    
    var searchResults: [FandomItem] {
        if searchText.isEmpty {
            return categoriesViewModel.categories?.sort(by: .alphabetical) ?? []
        } else {
            return categoriesViewModel.categories?.sort(by: .alphabetical).filter { $0.name.contains(searchText) } ?? []
        }
    }
    
    var body: some View {
        Group {
            if categoriesViewModel.isLoading {
                ProgressView()
                    .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
                    .tint(.textCustom)
            } else if categoriesViewModel.displayError {
                Text("There was a problem fetching the feed. Please try again later.")
            } else {
                listItems()
            }
        }
        .navigationTitle(title)
        .frame(maxWidth: .infinity, alignment: .center)
        .background(.backgroundCustom)
        .task {
            categoriesViewModel.fetchCategory(title)
        }
        .onDisappear {
            categoriesViewModel.cancelTasks()
        }
    }
    
    func listItems() -> some View {
        List {
            ForEach(searchResults, id: \.self) { fandom in
                VStack {
                    NavigationLink {
                        FeedView(title: fandom.name)
                    } label: {
                        Text(fandom.name)
                        
                        Text("\(fandom.worksCount)")
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .searchable(text: $searchText)
        .listStyle(PlainListStyle())
    }
}

#Preview {
    CategoriesView(title: "")
}
