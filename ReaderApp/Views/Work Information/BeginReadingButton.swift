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
            Text("Read Now")
                .foregroundStyle(.textCustom)
                .bold()
                .font(.title3)
                .padding(EdgeInsets(top: 10, leading: 40, bottom: 10, trailing: 40))
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(.backgroundCustom)
                )
                
        }
    }
}

#Preview {
    BeginReadingButton(workID: "")
}
