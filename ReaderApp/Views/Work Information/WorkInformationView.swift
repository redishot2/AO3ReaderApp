//
//  WorkInformationView.swift
//  ReaderApp
//
//  Created by Natasha Martinez on 3/3/25.
//

import AO3Scraper
import CoreData
import SwiftUI

struct WorkInformationView: View {
    @FetchRequest(sortDescriptors: []) var history: FetchedResults<WorkHistory>
    
    @State var feedCardInfo: FeedCardInfo
    
    enum Constants {
        static let imageWidth: CGFloat = 200
        static let imageHeight: CGFloat = 275
        static let noImageHight: CGFloat = 300
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Image("work-info-background")
                .resizable()
                .frame(height: 325)
                .aspectRatio(contentMode: .fit)
                .clipped()
                .blur(radius: 10)
            
            ZStack(alignment: .bottom) {
                ScrollView {
                    VStack {
                        coverImage()
                        
                        VStack(alignment: .leading) {
                            aboutView()
                            
                            storyInfoView()
                            
                            Spacer(minLength: 150)
                        }
                        .padding(EdgeInsets(top: 20, leading: 30, bottom: 0, trailing: 30))
                        .background(.backgroundCustom)
                    }
                }
                
                let curChapter = Int(history.first(where: { $0.workID == feedCardInfo.workID })?.curChapter ?? 0)
                BeginReadingButton(workID: feedCardInfo.workID, curChapter: curChapter)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            }
        }
        .navigationTitle("")
        .frame(maxWidth: .infinity)
        .ignoresSafeArea()
    }
    
    func coverImage() -> some View {
        VStack {
            CoverImageGeneratorView(title: feedCardInfo.title ?? "", author: feedCardInfo.displayAuthors())
                .frame(width: Constants.imageWidth, height: Constants.noImageHight)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(EdgeInsets(top: 100, leading: 0, bottom: 0, trailing: 0))
        }
    }
    
    func aboutView() -> some View {
        VStack(alignment: .leading) {
            if let workTitle = feedCardInfo.title {
                Text("\(workTitle)")
                    .font(.title2)
                    .bold()
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            
            HStack {
                Text("By ")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 5, trailing: 0))
                
                ForEach(feedCardInfo.authors, id: \.self) { author in
                    NavigationLink {
                        AuthorView(author: author)
                    } label: {
                        Text(author + (author == feedCardInfo.authors.last ? "" : ", "))
                            .font(.caption)
                            .foregroundStyle(.gray)
                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 5, trailing: 0))
                    }
                }
            }
            
            if let summary = feedCardInfo.summary {
                Divider()
                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                
                summary.convertToView()
            }
        }
    }
    
    func storyInfoView() -> some View {
        VStack(alignment: .leading) {
            Divider()
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
            
            tagsView()
            
            Divider()
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
            
            statsView(feedCardInfo.stats)
            
            Divider()
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
            
            ExpandableLinkView(links: feedCardInfo.tags.fandoms, groupTitle: "Fandoms")
            ExpandableLinkView(links: feedCardInfo.tags.characters, groupTitle: "Characters")
            ExpandableLinkView(links: feedCardInfo.tags.tags, groupTitle: "Tags")
        }
    }
    
    func tagsView() -> some View {
        VStack(alignment: .leading) {
            tagView(feedCardInfo.rating ?? .notRated)
            
            ForEach(feedCardInfo.tags.warnings, id: \.self) { warning in
                tagView(warning)
            }
            
            tagView(feedCardInfo.tags.category ?? .other)
            
            if feedCardInfo.stats.completed {
                statView(statName: "", statValue: "Completed", statIcon: "checkmark")
            } else {
                tagView(StoryInfo.CompletionStatus.inProgress)
            }
        }
    }
    
    func tagView(_ tag: TagsProtocol) -> some View {
        HStack {
            Text(tag.shortened)
                .foregroundStyle(.white)
                .minimumScaleFactor(0.01)
                .bold()
                .frame(width: 30, height: 30)
                .background(.highlight)
                .cornerRadius(5)
            
            Text(tag.fullText)
                .foregroundStyle(.textCustom)
                .multilineTextAlignment(.leading)
        }
    }
    
    func statsView(_ stats: FeedCardInfo.Stats) -> some View {
        VStack(alignment: .leading) {
            statView(statName: "Chapters", statValue: stats.chapters ?? "?/?", statIcon: "book.pages")
            
            statView(statName: "Words", statValue: stats.words ?? "0", statIcon: "pencil.and.scribble")
            
            statView(statName: "Comments", statValue: stats.comments ?? "0", statIcon: "quote.bubble")

            statView(statName: "Bookmarks", statValue: stats.bookmarks ?? "0", statIcon: "bookmark.circle")
            
            statView(statName: "Hits", statValue: stats.hits ?? "0", statIcon: "eyeglasses")
            
            statView(statName: "Kudos", statValue: stats.kudos ?? "0", statIcon: "heart.circle")
        }
    }
    
    func statView(statName: String, statValue: String, statIcon: String) -> some View {
        HStack {
            Image(systemName: statIcon)
                .font(.system(size: 15))
                .foregroundStyle(.white)
                .minimumScaleFactor(0.01)
                .bold()
                .frame(width: 30, height: 30)
                .background(.highlight)
                .cornerRadius(5)
            
            Text(statValue + " " + statName)
                .minimumScaleFactor(0.01)
                .foregroundStyle(.textCustom)
        }
    }
}
