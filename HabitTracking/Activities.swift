//
//  Activities.swift
//  HabitTracking
//
//  Created by Alex Po on 26.05.2022.
//

import Foundation

struct Activity: Codable, Identifiable, Equatable {
    var id = UUID()
    let name: String
    let description: String
    var lastCompleted: Date
    var completionCount: Int = 0
}

class Activities: ObservableObject {
    @Published var items = [Activity]() {
        didSet {
            DataManager.save(items, to: "SavedData")
        }
    }
    
    init() {
        items = DataManager.load(from: "SavedData")
        if items.isEmpty {
            items.append(Activity(name: "Vacillation", description: "The process that implies prolonged hesitation from inability to reach a firm decision", lastCompleted: Date.now, completionCount: 25))
        }
    }

//    static var example: Activities {
//        let activities = Activities()
//        activities.items.append(Activity(name: "Vacillation", description: "The process that implies prolonged hesitation from inability to reach a firm decision", lastCompleted: Date.now, completionCount: 25))
//        return activities
    
}
