//
//  WorkView.swift
//  ReaderApp
//
//  Created by Natasha Martinez on 5/5/25.
//

import SwiftUI

struct WorkView: View {
    @EnvironmentObject var workViewModel: WorkViewModel
    
    var body: some View {
        ScrollView {
            if workViewModel.isLoading {
                ProgressView()
                    .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
                    .tint(.systemWhite)
            } else if workViewModel.displayError {
                Text("There was a problem fetching this Work. Please try again later.")
            } else if let chapter = workViewModel.curChapterInfo {
                ChapterView(chapter: chapter)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 50, trailing: 10))
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .background(.systemWhite)
        .task {
            workViewModel.fetch()
        }
        .onDisappear {
            workViewModel.cancelTasks()
        }
    }
}

#Preview {
    WorkView()
}
