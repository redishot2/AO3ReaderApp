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
    private(set) var curChapter: Int
    private var workID: String
    
    var curChapterInfo: Chapter? {
        work?.chapters[curChapter]
    }
    
    private var tasks: [Task<Void, Never>] = []
    
    @Published var work: Work? = nil
    @Published var displayError: Bool = false
    @Published var isLoading: Bool = false
    
    public init(workID: String, curChapter: Int) {
        self.workID = workID
        self.curChapter = curChapter
    }
    
    func fetch() {
        isLoading = true
        
        let task = Task {
            if let newWork = await networking.fetch(work: workID, at: curChapter) {
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
        curChapter = curChapter + 1
        fetch()
    }
    
    func cancelTasks() {
        isLoading = false
        displayError = false
        tasks.forEach({ $0.cancel() })
        tasks = []
    }
}
