//
//  CustomButton.swift
//  ReaderApp
//
//  Created by Natasha Martinez on 5/7/25.
//

import SwiftUI

struct CustomButton: View {
    let text: String
    
    var body: some View {
        Text(text)
            .foregroundStyle(.white)
            .bold()
            .font(.title3)
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            .background(RoundedRectangle(cornerRadius: 20).foregroundStyle(.set1PinkDark))
    }
}

#Preview {
    CustomButton(text: "")
}
