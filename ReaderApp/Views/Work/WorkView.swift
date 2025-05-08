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
                    .tint(.set1PinkDark)
            } else if workViewModel.displayError {
                Text("There was a problem fetching this Work. Please try again later.")
            } else if let chapter = workViewModel.curChapter() {
                chapterMovementButtons()
                
                ChapterView(chapter: chapter)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 50, trailing: 10))
                
                chapterMovementButtons()
                
                Rectangle()
                    .frame(width: 1, height: 200)
                    .foregroundStyle(.systemWhite)
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
        .toolbar {
            if let chapterList = workViewModel.work?.chapterList, chapterList.chapterNames.count > 1 {
                createChapterListButton()
            }
        }
    }
    
    func createChapterListButton() -> some View {
        Menu(
            content: {
                let chapters = workViewModel.work?.chapterList?.chapterNames ?? []
                ForEach(Array(chapters.enumerated()), id: \.offset) { index, chapterName in
                    Button {
                        workViewModel.fetch(chapterIndex: index + 1)
                    } label: {
                        Text(chapterName)
                            .minimumScaleFactor(0.01)
                    }
                }
            }, label: {
                Image(systemName: "list.bullet")
            }
        )
    }
    
    func chapterMovementButtons() -> some View {
        HStack {
            if workViewModel.hasPreviousChapter {
                // Previous chapter
                CustomButton(text: "Previous Chapter")
                    .onTapGesture {
                        workViewModel.fetchPreviousChapter()
                    }
            }
            
            if workViewModel.hasNextChapter {
                // Next chapter
                CustomButton(text: "Next Chapter")
                    .onTapGesture {
                        workViewModel.fetchNextChapter()
                    }
            }
        }
    }
}

#Preview {
    WorkView()
}
