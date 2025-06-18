//
//  CategoriesViewModel.swift
//  ReaderApp
//
//  Created by Natasha Martinez on 6/17/25.
//

import AO3Scraper
import SwiftUI

@MainActor class CategoriesViewModel: ObservableObject {
    private let networking = FeedNetworking()
    
    private var tasks: [Task<Void, Never>] = []
    
    @Published var categories: CategoryInfo? = nil
    @Published var displayError: Bool = false
    @Published var isLoading: Bool = false
    
    func fetchCategory(_ searchTerm: String) {
        isLoading = true
        
        let task = Task {
            guard let category = Networking.Endpoint.Category(rawValue: searchTerm) else {
                isLoading = false
                displayError = true
                return
            }
            
            if let categoriesInfo = await networking.fetchCategory(category) {
                categories = categoriesInfo
            } else {
                displayError = true
            }
            isLoading = false
        }
        tasks.append(task)
    }
    
    func cancelTasks() {
        isLoading = false
        displayError = false
        tasks.forEach({ $0.cancel() })
        tasks = []
    }
}
