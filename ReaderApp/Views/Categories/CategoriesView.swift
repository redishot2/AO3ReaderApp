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
    
    var searchResults: [FandomGroup] {
        if searchText.isEmpty {
            return categoriesViewModel.categories?.sort(by: .alphabetical) ?? []
        } else {
            var groups: [FandomGroup] = []
            let unfiltered = categoriesViewModel.categories?.sort(by: .alphabetical) ?? []
            for fandoms in unfiltered {
                let filteredFandoms: [FandomItem] = fandoms.fandoms.filter { $0.name.contains(searchText) }
                if filteredFandoms.isEmpty { continue }
                groups.append(FandomGroup(name: fandoms.name, fandoms: filteredFandoms))
            }
            
            return groups
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
            ForEach(searchResults, id: \.self) { fandomGroup in
                Section(fandomGroup.name) {
                    ForEach(fandomGroup.fandoms, id: \.self) { fandom in
                        NavigationLink {
                            FeedView(title: fandom.name)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(fandom.name)
                                    .font(.title3)
                                    .foregroundStyle(.textCustom)
                                
                                Text("\(fandom.worksCount) works")
                                    .font(.body)
                                    .foregroundStyle(.textCustom)
                            }
                        }
                        .buttonStyle(.plain)
                    }
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
