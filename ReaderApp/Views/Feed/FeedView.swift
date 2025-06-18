//
//  FeedView.swift
//  ReaderApp
//
//  Created by Natasha Martinez on 3/3/25.
//

import AO3Scraper
import SwiftUI

struct FeedView: View {
    let title: String
    
    @StateObject var feedViewModel = FeedViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(feedViewModel.feedInfo?.feedInfo ?? [], id: \.self) { feedCardInfo in
                    NavigationLink {
                        WorkInformationView(feedCardInfo: feedCardInfo)
                    } label: {
                        FeedCardView(feedCardInfo: feedCardInfo)
                            .padding()
                            .onAppear {
                                if feedCardInfo == feedViewModel.feedInfo?.feedInfo.last {
                                    feedViewModel.fetchNextPage(for: title)
                                }
                            }
                    }
                    .buttonStyle(.plain)
                }
            }
            
            if feedViewModel.isLoading {
                ProgressView()
                    .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
                    .tint(.textCustom)
            } else if feedViewModel.displayError {
                Text("There was a problem fetching the feed. Please try again later.")
            } else if feedViewModel.hasScrolledToEnd {
                Image(systemName: "fireworks")
                    .padding(100)
                    .foregroundStyle(.textCustom)
            }
        }
        .navigationTitle(title)
        .frame(maxWidth: .infinity, alignment: .center)
        .background(.divider)
        .task {
            feedViewModel.fetchFeedInfo(for: title)
        }
        .onDisappear {
            feedViewModel.cancelTasks()
        }
    }
}
