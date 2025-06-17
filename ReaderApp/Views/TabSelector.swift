//
//  TabSelector.swift
//  ReaderApp
//
//  Created by Natasha Martinez on 5/13/25.
//

import SwiftUI

struct TabItem: Hashable, Equatable {
    let name: String
//    let content: some View
}

struct TabSelector: View {
    let items: [TabItem]
    
    @State var reference = 0
    
    var body: some View {
        VStack {
            HStack{
                ForEach(Array(items.enumerated()), id: \.element) { index, item in
                    Button(item.name) {
                        reference = index
                    }
                    .tint(Color.blue)
                    .modifier(StyleMod(isActive: reference == index))
                }
            }
            
//            items[reference].content
        }
    }
}

#Preview {
    TabSelector(items: [])
}

struct StyleMod: ViewModifier {
    let isActive: Bool
    func body(content: Content) -> some View {
        content
            .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
            .foregroundStyle(isActive ? .textCustom : .gray)
            .background(isActive ? .backgroundCustom : .gray)
    }
}
