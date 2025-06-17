//
//  AuthorView.swift
//  ReaderApp
//
//  Created by Natasha Martinez on 5/7/25.
//

import SwiftUI
import AO3Scraper

struct AuthorView: View {
    let author: String
    
    @StateObject var authorViewModel = AuthorViewModel()
    
    var body: some View {
        ScrollView {
            Rectangle()
                .frame(width: 30, height: 10, alignment: .center)
                .foregroundColor(.clear)
            
            createHeader()
            
            // Bio
            VStack {
                if let bioText = authorViewModel.userInfo?.profileInfo.bio {
                    bioText.convertToView()
                }
            }.padding(EdgeInsets(top: 20, leading: 60, bottom: 10, trailing: 60))
            
            // User activity
//            VStack(spacing: 0) {
//                createWorkGroup(groupTitle: "Recent Works", works: authorViewModel.userInfo?.recentWorks)
//                createWorkGroup(groupTitle: "Recent Series", works: authorViewModel.userInfo?.recentSeries)
//                createWorkGroup(groupTitle: "Recent Bookmarks", works: authorViewModel.userInfo?.recentBookmarks)
//            }
            
            TabSelector(items: [
                TabItem(name: "Recent Works"),
                TabItem(name: "Recent Series"),
                TabItem(name: "Recent Bookmarks")
            ])
            
            if authorViewModel.isLoading {
                ProgressView()
                    .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
                    .tint(.systemWhite)
            } else if authorViewModel.displayError {
                Text("There was a problem fetching the feed. Please try again later.")
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .background(.set1PinkDark)
        .task {
            authorViewModel.fetchProfile(for: author)
        }
        .onDisappear {
            authorViewModel.cancelTasks()
        }
    }
    
    private func createHeader() -> some View {
        VStack {
            ProfilePic(coverImage: authorViewModel.userInfo?.profileInfo.profilePicture)
                .frame(width: 200, height: 200, alignment: .center)
            
            Text(authorViewModel.userInfo?.profileInfo.username ?? "Profile")
                .font(.title)
                .minimumScaleFactor(0.01)
                .foregroundStyle(.systemWhite)
            
            if let joinDate = authorViewModel.userInfo?.profileInfo.joinDate {
                Text("Joined\n\(joinDate)")
                    .font(.subheadline)
                    .minimumScaleFactor(0.01)
                    .foregroundStyle(.systemWhite)
            }
            
            Rectangle()
                .frame(width: 30, height: 10, alignment: .center)
                .foregroundColor(.clear)
            
            profileHeader()
        }
    }
    
    private func createWorkGroup(groupTitle: String, works: [FeedCardInfo]?) -> some View {
        VStack {
            if let recentWorks = works, !recentWorks.isEmpty {
                VStack {
                    
                    // Divider
                    Divider()
                    
                    // Title
                    Text(groupTitle)
                        .foregroundStyle(.systemWhite)
                        .font(.title)
                        .minimumScaleFactor(0.01)

                    // Cards
                    ForEach(recentWorks, id: \.self) { feedCardInfo in
                        FeedCardView(feedCardInfo: feedCardInfo)
                    }
                    
                    // Spacer
                    Divider()
                }
                .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
            }
        }
        .background(.set1PinkDark)
    }
    
    func profileHeader() -> some View {
        HStack {
            VStack {
                Text(String(authorViewModel.userInfo?.counts.works ?? 0))
                    .font(.headline)
                    .minimumScaleFactor(0.01)
                    .foregroundStyle(.systemWhite)
                Text("Works")
                    .font(.caption)
                    .minimumScaleFactor(0.01)
                    .foregroundStyle(.systemWhite)
            }
            
            VStack {
                Text(String(authorViewModel.userInfo?.counts.bookmarks ?? 0))
                    .font(.headline)
                    .minimumScaleFactor(0.01)
                    .foregroundStyle(.systemWhite)
                Text("Bookmarks")
                    .font(.caption)
                    .minimumScaleFactor(0.01)
                    .foregroundStyle(.systemWhite)
            }
            
            VStack {
                Text(String(authorViewModel.userInfo?.fandoms.count ?? 0))
                    .font(.headline)
                    .minimumScaleFactor(0.01)
                    .foregroundStyle(.systemWhite)
                Text("Fandoms")
                    .font(.caption)
                    .minimumScaleFactor(0.01)
                    .foregroundStyle(.systemWhite)
            }
        }
    }
}

#Preview {
    AuthorView(author: "")
}
