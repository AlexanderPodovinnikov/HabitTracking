//
//  FileManadger-DataManager.swift
//  HabitTracking
//
//  Created by Alex Po on 26.05.2022.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

struct DataManager {
    
    
    static func load<T: Decodable>(from path: String) -> [T] {
        let savePath = FileManager.documentsDirectory.appendingPathComponent(path)
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode([T].self, from: data) {
                return decoded
            }
        }
        return []
    }
    
    static func save<T: Encodable>(_ items: [T], to path: String) {
        let savePath = FileManager.documentsDirectory.appendingPathComponent(path)
        if let encoded = try? JSONEncoder().encode(items) {
            try? encoded.write(to: savePath, options: [.atomic, .completeFileProtection])
        }
    }
}
