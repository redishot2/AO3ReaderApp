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
                    .padding(EdgeInsets(top: 20, leading: 10, bottom: 50, trailing: 10))
                
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
                    .tint(.set1PinkDark)
            }
        )
    }
    
    func chapterMovementButtons() -> some View {
        HStack {
            if workViewModel.hasPreviousChapter {
                // Previous chapter
                chapterButton(text: "Previous Chapter")
                    .onTapGesture {
                        workViewModel.fetchPreviousChapter()
                    }
            }
            
            Spacer()
            
            if workViewModel.hasNextChapter {
                // Next chapter
                chapterButton(text: "Next Chapter")
                    .onTapGesture {
                        workViewModel.fetchNextChapter()
                    }
            }
        }
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
    }
    
    func chapterButton(text: String) -> some View {
        Text(text)
            .foregroundStyle(.set1PinkDark)
            .bold()
            .font(.title3)
            .padding(EdgeInsets(top: 2, leading: 20, bottom: 2, trailing: 20))
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.primary, lineWidth: 1)
                    .foregroundStyle(.systemWhite)
            )
    }
}

#Preview {
    WorkView()
}
