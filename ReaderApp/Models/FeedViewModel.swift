//
//  FeedViewModel.swift
//  ReaderApp
//
//  Created by Natasha Martinez on 4/8/25.
//

import AO3Scraper
import SwiftUI

@MainActor class FeedViewModel: ObservableObject {
    let networking = FeedNetworking()
    private(set) var curFeedPage = 0
    
    private var tasks: [Task<Void, Never>] = []
    
    @Published var feedInfo: FeedInfo? = nil
    @Published var displayError: Bool = false
    @Published var isLoading: Bool = false
    @Published var hasScrolledToEnd: Bool = false
    
    func fetchFeedInfo(for searchTerm: String) {
        isLoading = true
        
        let task = Task {
            if let newFeedInfo = await networking.fetchRelatedWorks(searchTerm, page: curFeedPage) {
                if feedInfo == nil {
                    feedInfo = newFeedInfo
                } else {
                    feedInfo?.addFeedInfo(from: newFeedInfo)
                }
            } else {
                displayError = true
            }
            isLoading = false
        }
        tasks.append(task)
    }
    
    func fetchNextPage(for searchTerm: String) {
        guard !isLoading else { return }
        
        curFeedPage = curFeedPage + 1
        guard curFeedPage < feedInfo?.pagesCount ?? 0 else {
            hasScrolledToEnd = true
            return
        }
        
        fetchFeedInfo(for: searchTerm)
    }
    
    func cancelTasks() {
        isLoading = false
        displayError = false
        hasScrolledToEnd = false
        tasks.forEach({ $0.cancel() })
        tasks = []
    }
}
