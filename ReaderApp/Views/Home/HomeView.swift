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
            Text("Second time+")
        }
    }
}

#Preview {
    HomeView()
}
