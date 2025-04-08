//
//  FeedCardView.swift
//  ReaderApp
//
//  Created by Natasha Martinez on 4/8/25.
//

import AO3Scraper
import SwiftUI

struct FeedCardView: View {
    let feedCardInfo: FeedCardInfo
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(feedCardInfo.title ?? "")
                .font(.title3)
                .multilineTextAlignment(.leading)
                .foregroundStyle(.systemBlack)
                .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
            
            Text("By \(feedCardInfo.author)")
                .font(.subheadline)
                .multilineTextAlignment(.leading)
                .foregroundStyle(.gray)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
            
            VStack(alignment: .leading) {
                let fandoms = getFandoms(feedCardInfo)
                
                ForEach(fandoms, id: \.self) { fandom in
                    Text(fandom)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(.set1PinkDark)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 1, trailing: 0))
                }
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 9, trailing: 0))
            
            feedCardInfo.summary?.convertToView()
            
            if let rating = feedCardInfo.rating {
                tagView(rating)
            }
            
            ForEach(feedCardInfo.tags.warnings, id: \.self) { warning in
                tagView(warning)
            }
            
            tagView(feedCardInfo.tags.category ?? .other)
            
            let status: StoryInfo.CompletionStatus = feedCardInfo.stats.completed ? .completed : .inProgress
            tagView(status, additionalText: getChapterText(feedCardInfo))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(EdgeInsets(top: 20, leading: 20, bottom: 30, trailing: 20))
        .background(.systemWhite)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
    func tagView(_ tag: TagsProtocol, additionalText: String? = nil) -> some View {
        HStack {
            Text(tag.shortened)
                .foregroundStyle(.white)
                .minimumScaleFactor(0.01)
                .bold()
                .frame(width: 30, height: 30)
                .background(.set1PinkDark)
                .cornerRadius(5)
            
            Text(tag.fullText + (additionalText ?? ""))
                .foregroundStyle(.set1PinkDark)
                .multilineTextAlignment(.leading)
        }
    }
    
    func getChapterText(_ feedCardInfo: FeedCardInfo) -> String {
        guard let chapter = feedCardInfo.stats.chapters else {
            return ""
        }
        
        return " \(chapter) Chapters"
    }
    
    func getFandoms(_ feedCardInfo: FeedCardInfo) -> [String] {
        var fandoms: [String] = feedCardInfo.tags.fandoms.count > 3 ? Array(feedCardInfo.tags.fandoms[0..<3]) : feedCardInfo.tags.fandoms
        
        if fandoms.count != feedCardInfo.tags.fandoms.count {
            let hiddenCount = "...plus \(feedCardInfo.tags.fandoms.count - 3) more"
            fandoms.append(hiddenCount)
        }
        
        return fandoms
    }
}
