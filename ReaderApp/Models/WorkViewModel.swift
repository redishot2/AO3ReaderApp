//
//  WorkViewModel.swift
//  ReaderApp
//
//  Created by Natasha Martinez on 5/5/25.
//

import AO3Scraper
import SwiftUI

@MainActor class WorkViewModel: ObservableObject {
    let networking = ChapterNetworking()
    private(set) var curChapterIndex: Int
    private var workID: String
    
    private var tasks: [Task<Void, Never>] = []
    
    @Published var work: Work? = nil
    @Published var displayError: Bool = false
    @Published var isLoading: Bool = false
    
    public init(workID: String, curChapter: Int) {
        self.workID = workID
        self.curChapterIndex = curChapter
    }
    
    /// Fetches chapter for provided work
    /// - Parameter chapterIndex: starts counting at 1
    func fetch(chapterIndex: Int? = nil) {
        isLoading = true
        curChapterIndex = chapterIndex ?? curChapterIndex
        
        let task = Task {
            if let newWork = await networking.fetch(work: workID, at: curChapterIndex) {
                work = newWork
            } else {
                displayError = true
            }
            isLoading = false
        }
        tasks.append(task)
    }
    
    func fetchNextChapter() {
        cancelTasks()
        curChapterIndex = curChapterIndex + 1
        fetch()
    }
    
    func curChapter() -> Chapter? {
        work?.chapters[curChapterIndex]
    }
    
    func cancelTasks() {
        isLoading = false
        displayError = false
        tasks.forEach({ $0.cancel() })
        tasks = []
    }
}
