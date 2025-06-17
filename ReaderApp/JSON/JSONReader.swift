//
//  JSONReader.swift
//  ReaderApp
//
//  Created by Natasha Martinez on 6/17/25.
//

import Foundation

class JSONReader {
    static func readJSONFile<T: Decodable>(named fileName: String, expectedType: T.Type) -> T? {
        guard let rawData = findData(named: fileName) else { return nil }
        
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: rawData)
            return decodedData
        } catch {
            print("error: \(error)")
        }
        
        return nil
    }
    
    private static func findData(named fileName: String) -> Data? {
        guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            return nil
        }
        do {
            return try Data(contentsOf: fileURL)
        } catch {
            return nil
        }
    }
}
