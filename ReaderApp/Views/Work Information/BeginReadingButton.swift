//
//  BeginReadingButton.swift
//  ReaderApp
//
//  Created by Natasha Martinez on 5/5/25.
//

import SwiftUI

struct BeginReadingButton: View {
    let workID: String
    
    var body: some View {
        NavigationLink {
            WorkView()
                .environmentObject(WorkViewModel(workID: workID, curChapter: 1))
        } label: {
            CustomButton(text: "Read Now")
                
        }
    }
}

#Preview {
    BeginReadingButton(workID: "")
}
