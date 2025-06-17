//
//  HomeView.swift
//  ReaderApp
//
//  Created by Natasha Martinez on 6/13/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeViewModel = HomeViewModel()
    
    var body: some View {
        if homeViewModel.firstTimeUser {
            FirstTimeView(showFirstTimeUser: $homeViewModel.firstTimeUser)
        } else {
            ScrollView {
                categoryList()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    private func categoryList() -> some View {
        HStack(alignment: .top, spacing: 5) {
            VStack(alignment: .leading) {
                ForEach(homeViewModel.categories.leftColumn, id: \.self) { category in
                    categoryView(category)
                }
            }
            
            VStack(alignment: .leading) {
                ForEach(homeViewModel.categories.rightColumn, id: \.self) { category in
                    categoryView(category)
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
    }
    
    private func categoryView(_ category: Category) -> some View {
        NavigationLink {
            FeedView(title: category.webName)
        } label: {
            HStack {
                Image(category.imageName)
                    .resizable()
                    .frame(width: 40, height: 40)
                
                Text(category.displayName)
                
                Spacer()
            }
            .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 5))
            .glassEffect()
        }
    }
}

#Preview {
    HomeView()
}
