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
        Group {
            if categoriesViewModel.isLoading {
                ProgressView()
                    .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
                    .tint(.textCustom)
            } else if categoriesViewModel.displayError {
                Text("There was a problem fetching the feed. Please try again later.")
            } else {
                CategoryListView()
                    .environmentObject(categoriesViewModel)
            }
        }
        .navigationTitle(title)
        .toolbar {
            Menu {
                ForEach(CategoryInfo.SortType.all(), id: \.self) { sortType in
                    Button {
                        categoriesViewModel.sortType = sortType
                    } label: {
                        HStack {
                            Text(sortType.rawValue)
                            
                            Spacer()
                            
                            if sortType == categoriesViewModel.sortType {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            } label: {
                Image(systemName: "line.3.horizontal.decrease.circle")
            }

        }
        .frame(maxWidth: .infinity, alignment: .center)
        .background(.backgroundCustom)
        .task {
            categoriesViewModel.fetchCategory(title)
        }
        .onDisappear {
            categoriesViewModel.cancelTasks()
        }
    }
}

#Preview {
    CategoriesView(title: "")
}
