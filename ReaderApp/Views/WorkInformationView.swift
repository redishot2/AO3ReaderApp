//
//  WorkInformationView.swift
//  ReaderApp
//
//  Created by Natasha Martinez on 3/3/25.
//

import SwiftUI
import AO3Scraper

struct WorkInformationView: View {
    @State var work: Work
    
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
                        }
                        .padding(EdgeInsets(top: 20, leading: 30, bottom: 0, trailing: 30))
                        .background(.systemWhite)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .ignoresSafeArea()
    }
    
    func coverImage() -> some View {
        VStack {
            if let url = work.currentChapter?.firstImage {
                CacheAsyncImage(url: url) { state in
                    if let image = state.image {
                        image
                            .resizable()
                            .frame(width: Constants.imageWidth, height: Constants.imageHeight)
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(EdgeInsets(top: 100, leading: 0, bottom: 0, trailing: 0))
                    }
                }
            } else {
                CoverImageGeneratorView(title: work.aboutInfo?.title ?? "", author: work.aboutInfo?.author.name ?? "")
                    .frame(width: Constants.imageWidth, height: Constants.noImageHight)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(EdgeInsets(top: 100, leading: 0, bottom: 0, trailing: 0))
            }
        }
    }
    
    func aboutView() -> some View {
        VStack(alignment: .leading) {
            if let workTitle = work.aboutInfo?.title {
                Text("\(workTitle)")
                    .font(.title2)
                    .bold()
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            
            if let author = work.aboutInfo?.author.name {
                Text("by: \(author)")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 5, trailing: 0))
            }
            
            Divider()
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
            
            work.aboutInfo?.summary.convertToView()
                .multilineTextAlignment(.leading)
        }
    }
    
    func tagsView(_ storyInfo: StoryInfo) -> some View {
        VStack(alignment: .leading) {
            tagView(storyInfo.rating)
            
            ForEach(storyInfo.warnings, id: \.self) { warning in
                tagView(warning)
            }
            
            ForEach(storyInfo.categories, id: \.self) { category in
                tagView(category)
            }
            
            if let completedDate = storyInfo.stats.completed {
                statView(statName: "", statValue: "Completed \(completedDate.formatted(date: .abbreviated, time: .omitted))", statIcon: "checkmark")
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
                .background(.set1PinkDark)
                .cornerRadius(5)
            
            Text(tag.fullText)
                .foregroundStyle(.set1PinkDark)
        }
    }
    
    func statsView(_ stats: StoryInfo.Stats) -> some View {
        VStack(alignment: .leading) {
            statView(statName: "Chapters", statValue: stats.chapters, statIcon: "book.pages")
            
            statView(statName: "Words", statValue: stats.words.displayString(), statIcon: "pencil.and.scribble")
            
            statView(statName: "Comments", statValue: stats.comments.displayString(), statIcon: "quote.bubble")

            statView(statName: "Bookmarks", statValue: stats.bookmarks.displayString(), statIcon: "bookmark.circle")
            
            statView(statName: "Hits", statValue: stats.hits.displayString(), statIcon: "eyeglasses")
            
            statView(statName: "Kudos", statValue: stats.kudos.displayString(), statIcon: "heart.circle")
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
                .background(.set1PinkDark)
                .cornerRadius(5)
            
            Text(statValue + " " + statName)
                .minimumScaleFactor(0.01)
                .foregroundStyle(.set1PinkDark)
        }
    }
    
    func storyInfoView() -> some View {
        VStack(alignment: .leading) {
            if let storyInfo = work.storyInfo {
                Divider()
                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                
                tagsView(storyInfo)
                
                Divider()
                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                
                statsView(storyInfo.stats)
                
                Divider()
                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                
                ExpandableLinkView(links: storyInfo.fandoms, groupTitle: "Fandoms")
                ExpandableLinkView(links: storyInfo.characters, groupTitle: "Characters")
                ExpandableLinkView(links: storyInfo.tags, groupTitle: "Tags")
            }
            
            Spacer(minLength: 150)
        }
    }
}
