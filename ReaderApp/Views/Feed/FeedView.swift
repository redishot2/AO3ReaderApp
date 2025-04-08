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
    let networking = FeedNetworking()
    
    @State var feedInfo: FeedInfo? = nil
    
    var body: some View {
        ScrollView {
            if let feedInfo = feedInfo {
                ForEach(feedInfo.feedInfo, id: \.self) { feedCardInfo in
                    NavigationLink {
                        WorkInformationView(feedCardInfo: feedCardInfo)
                    } label: {
                        FeedCardView(feedCardInfo: feedCardInfo)
                            .padding()
                    }
                    .buttonStyle(.plain)
                }
            } else {
                Text("Loading...")
            }
        }
        .background(Color.set1PinkDark)
        .task {
            feedInfo = await networking.fetchRelatedWorks(title, page: 0)
        }
    }
}
