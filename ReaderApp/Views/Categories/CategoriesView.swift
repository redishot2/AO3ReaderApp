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
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(categoriesViewModel.categories?.fandoms ?? [], id: \.self) { fandomGrouping in
                    fandoms(in: fandomGrouping)
                }
            }
            
            if categoriesViewModel.isLoading {
                ProgressView()
                    .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
                    .tint(.textCustom)
            } else if categoriesViewModel.displayError {
                Text("There was a problem fetching the feed. Please try again later.")
            } else if categoriesViewModel.hasScrolledToEnd {
                Image(systemName: "fireworks")
                    .padding(100)
                    .foregroundStyle(.textCustom)
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
    
    func fandoms(in fandomGroup: FandomGroup) -> some View {
        ForEach(fandomGroup.fandoms, id: \.self) { fandom in
            NavigationLink {
                FeedView(title: fandom.name)
            } label: {
                Text(fandom.name)
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    CategoriesView(title: "")
}
