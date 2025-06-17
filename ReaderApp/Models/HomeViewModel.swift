//
//  HomeViewModel.swift
//  ReaderApp
//
//  Created by Natasha Martinez on 6/17/25.
//

import Foundation
import SwiftUI

struct Categories {
    var categories: [Category]
    
    var leftColumn: [Category] {
        stride(from: 0, to: categories.count, by: 2).map { categories[$0] }
    }
    
    var rightColumn: [Category] {
        stride(from: 1, to: categories.count, by: 2).map { categories[$0] }
    }
    
    init(categories: [Category]?) {
        self.categories = categories ?? []
    }
}

struct Category: Codable, Hashable {
    let displayName: String
    let webName: String
    let imageName: String
}

@MainActor class HomeViewModel: ObservableObject {
    @AppStorage("firstTime") var firstTimeUser = true
    @Published var categories: Categories
    
    init() {
        let categories = JSONReader.readJSONFile(named: "Categories", expectedType: [Category].self)
        self.categories = Categories(categories: categories)
    }
}
