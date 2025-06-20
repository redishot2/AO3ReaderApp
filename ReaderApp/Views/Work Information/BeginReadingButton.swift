//
//  BeginReadingButton.swift
//  ReaderApp
//
//  Created by Natasha Martinez on 5/5/25.
//

import SwiftUI

struct BeginReadingButton: View {
    let workID: String
    let curChapter: Int
    
    var body: some View {
        NavigationLink {
            WorkView()
                .environmentObject(WorkViewModel(workID: workID, curChapter: curChapter > 0 ? curChapter : 1))
        } label: {
            Text(curChapter == 0 ? "Read Now" : "Continue Chapter \(curChapter)")
                .foregroundStyle(.white)
                .bold()
                .font(.title3)
                .padding(EdgeInsets(top: 10, leading: 40, bottom: 10, trailing: 40))
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(.highlight)
                )
                
        }
    }
}

#Preview {
    BeginReadingButton(workID: "", curChapter: 0)
}
