//
//  AuthorViewModel.swift
//  ReaderApp
//
//  Created by Natasha Martinez on 5/7/25.
//

import AO3Scraper
import SwiftUI

@MainActor class AuthorViewModel: ObservableObject {
    private let networking = ProfileNetworking()
    
    private var tasks: [Task<Void, Never>] = []
    
    @Published var userInfo: UserInfo? = nil
    @Published var displayError: Bool = false
    @Published var isLoading: Bool = false
    
    func fetchProfile(for userName: String) {
        isLoading = true
        
        let task = Task {
            if let newProfile = await networking.fetch(userName, profilePage: .dashboard) {
                if userInfo == nil {
                    userInfo = newProfile
                } else {
                    userInfo = newProfile
                }
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
