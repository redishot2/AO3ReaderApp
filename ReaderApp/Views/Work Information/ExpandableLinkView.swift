//
//  ExpandableLinkView.swift
//  ReaderApp
//
//  Created by Natasha Martinez on 3/3/25.
//

import AO3Scraper
import SwiftUI

struct ExpandableLinkView: View {
    let links: [String]
    let groupTitle: String
    let smallerDisplay = 6
    
    var displayLinks: [String] {
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
                .foregroundStyle(.textCustom)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
            
            ForEach(displayLinks, id: \.self) { link in
                NavigationLink {
                    FeedView(title: link)
                } label: {
                    Text(link)
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(.textCustom)
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
                        .foregroundStyle(.backgroundCustom)
                }

            }
        }
        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
    }
}
