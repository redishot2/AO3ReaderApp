//
//  CoverImageGeneratorView.swift
//  ReaderApp
//
//  Created by Natasha Martinez on 3/3/25.
//

import SwiftUI

struct CoverImageGeneratorView: View {
    let title: String
    let author: String
    
    var body: some View {
        ZStack(alignment: .top) {
            Image("bookCover")
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            VStack {
                Text(title)
                    .font(.system(size: 35, weight: .ultraLight, design: .serif))
                    .minimumScaleFactor(0.01)
                    .multilineTextAlignment(.center)
                    .bold()
                    .foregroundStyle(.yellow)
                    .padding(EdgeInsets(top: 70, leading: 55, bottom: 30, trailing: 55))
                
                Text(author)
                    .font(.system(size: 10, weight: .ultraLight, design: .serif))
                    .minimumScaleFactor(0.01)
                    .multilineTextAlignment(.center)
                    .bold()
                    .foregroundStyle(.yellow)
                    .padding(EdgeInsets(top: 10, leading: 55, bottom: 80, trailing: 55))
            }
        }
    }
}
