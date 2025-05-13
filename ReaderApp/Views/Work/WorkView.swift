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
                ChapterView(chapter: chapter)
                    .padding(EdgeInsets(top: 20, leading: 10, bottom: 50, trailing: 10))
                
                chapterMovementButtons()
                
                Rectangle()
                    .frame(width: 1, height: 200)
                    .foregroundStyle(.systemWhite)
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .background(.systemWhite)
        .navigationTitle(workViewModel.curChapter()?.title ?? "")
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
                    .tint(.set1PinkDark)
            }
        )
    }
    
    func chapterMovementButtons() -> some View {
        HStack {
            if workViewModel.hasPreviousChapter {
                // Previous chapter
                Text("Previous Chapter")
                    .foregroundStyle(.set1Pink)
                    .bold()
                    .font(.title3)
                    .padding(EdgeInsets(top: 2, leading: 20, bottom: 2, trailing: 20))
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundStyle(.set1PinkDark)
                    )
                    .onTapGesture {
                        workViewModel.fetchPreviousChapter()
                    }
            }
            
            Spacer()
            
            if workViewModel.hasNextChapter {
                // Next chapter
                Text("Next Chapter")
                    .foregroundStyle(.systemWhite)
                    .bold()
                    .font(.title3)
                    .padding(EdgeInsets(top: 2, leading: 20, bottom: 2, trailing: 20))
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundStyle(.set1Pink)
                    )
                    .onTapGesture {
                        workViewModel.fetchNextChapter()
                    }
            }
        }
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
    }
}

#Preview {
    WorkView()
}
