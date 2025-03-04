//
//  Int+Utilities.swift
//  ReaderApp
//
//  Created by Natasha Martinez on 3/3/25.
//

extension Int {
    func displayString() -> String {
        return self.formatted(.number.notation(.compactName))
    }
}
