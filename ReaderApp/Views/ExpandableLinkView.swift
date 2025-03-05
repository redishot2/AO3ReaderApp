//
//  ExpandableLinkView.swift
//  ReaderApp
//
//  Created by Natasha Martinez on 3/3/25.
//

import AO3Scraper
import SwiftUI

struct ExpandableLinkView: View {
    let links: [LinkInfo]
    let groupTitle: String
    let smallerDisplay = 6
    
    var displayLinks: [LinkInfo] {
        if links.count > smallerDisplay && !isExpanded {
            return Array(links[0..<smallerDisplay])
        } else {
            return links
        }
    }
    
    @State var isExpanded = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(groupTitle)
                .font(.title3)
                .foregroundStyle(.set1PinkDark)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
            
            ForEach(displayLinks) { link in
                NavigationLink {
                    FeedView(title: link.name)
                } label: {
                    Text(link.name)
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(.systemBlack)
                        .underline()
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                }
            }
            
            if links.count > smallerDisplay {
                let toggleText = isExpanded ? "Show less..." : "Show more..."
                Button {
                    isExpanded.toggle()
                } label: {
                    Text(toggleText)
                        .foregroundStyle(.set1PinkDark)
                }

            }
        }
        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
    }
}
