//
//  HomeViewModel.swift
//  ReaderApp
//
//  Created by Natasha Martinez on 6/17/25.
//

import Foundation
import SwiftUI

@MainActor class HomeViewModel: ObservableObject {
    @AppStorage("firstTime") var firstTimeUser = true
}
