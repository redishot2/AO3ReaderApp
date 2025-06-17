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
            .padding(EdgeInsets(top: 30, leading: 15, bottom: 0, trailing: 15))
            .background(.divider)
        }
    }
    
    private func categoryList() -> some View {
        VStack(alignment: .leading) {
            Text("Explore Fandoms")
                .font(.title2)
                .padding(EdgeInsets(top: 0, leading: 25, bottom: 10, trailing: 5))
            
            let spacing: CGFloat = 15.0
            HStack(alignment: .top, spacing: spacing) {
                VStack(alignment: .leading, spacing: spacing) {
                    ForEach(homeViewModel.categories.leftColumn, id: \.self) { category in
                        categoryView(category)
                    }
                }
                
                VStack(alignment: .leading, spacing: spacing) {
                    ForEach(homeViewModel.categories.rightColumn, id: \.self) { category in
                        categoryView(category)
                    }
                }
            }
        }
    }
    
    private func categoryView(_ category: Category) -> some View {
        NavigationLink {
            CategoriesView(title: category.webName)
        } label: {
            HStack {
                Image(systemName: category.imageName)
                    .font(.body)
                    .tint(.textCustom)
                    .frame(width: 40)
                
                Text(category.displayName)
                    .lineLimit(1)
                    .allowsTightening(true)
                    .font(.body)
                    .foregroundStyle(.textCustom)
                
                Spacer()
            }
            .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 5))
            .background(.background)
            .clipShape(Capsule())
        }
        .buttonStyle(.borderless)
    }
}

#Preview {
    HomeView()
}
