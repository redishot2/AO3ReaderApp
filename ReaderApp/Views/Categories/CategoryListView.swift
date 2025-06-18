//
//  CategoryListView.swift
//  ReaderApp
//
//  Created by Natasha Martinez on 6/18/25.
//

import AO3Scraper
import SwiftUI

struct CategoryListView: View {
    
    @EnvironmentObject var categoriesViewModel: CategoriesViewModel
    
    var searchResults: [FandomGroup] {
        let unfiltered = categoriesViewModel.categories?.sort(by: categoriesViewModel.sortType) ?? []
        
        if categoriesViewModel.searchText.isEmpty {
            return unfiltered
        } else {
            var groups: [FandomGroup] = []
            for fandoms in unfiltered {
                let filteredFandoms: [FandomItem] = fandoms.fandoms.filter {
                    $0.name.contains(categoriesViewModel.searchText)
                }
                
                if filteredFandoms.isEmpty { continue }
                
                groups.append(FandomGroup(name: fandoms.name, fandoms: filteredFandoms))
            }
            
            return groups
        }
    }
    
    var body: some View {
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
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .searchable(text: $categoriesViewModel.searchText)
        .listStyle(PlainListStyle())
    }
}

#Preview {
    CategoryListView()
}
