//
//  FirstTimeView.swift
//  ReaderApp
//
//  Created by Natasha Martinez on 6/13/25.
//

import SwiftUI

struct FirstTimeView: View {
    @State private var fadedIn = false
    @State private var fadeOut = false
    
    var body: some View {
        VStack {
            VStack {
                Image("launch")
                    .resizable()
                    .scaleEffect(fadeOut ? 5 : 1)
                
                Text("Ink Hive")
                    .font(.largeTitle)
                    .foregroundStyle(.primary)
                
                Text("buzzing with stories")
                    .font(.title3)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, maxHeight: 500)
        }
        .opacity(fadedIn ? 1 : 0)
        .opacity(fadeOut ? 0 : 1)
        .frame(maxHeight: .infinity)
        .background(.almostWhite)
        .onAppear {
            withAnimation(.easeInOut(duration: 1)) {
                fadedIn = true
            } completion: {
                withAnimation(.easeInOut(duration: 0.5).delay(0.25)) {
                    fadeOut = true
                } completion: {
                    // Done
                }
            }
        }
    }
}

#Preview {
    FirstTimeView()
}
