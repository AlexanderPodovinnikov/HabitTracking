//
//  AddView.swift
//  HabitTracking
//
//  Created by Alex Po on 26.05.2022.
//

import SwiftUI

struct AddView: View {
    
    @State private var name = ""
    @State private var description = ""
    @State private var lastCompleted = Date()
    @ObservedObject var activities: Activities 
    
    var body: some View {
        NavigationView {
            Form {
                Section("Short name") {
                    TextField("name", text: $name)
                }
                Section("Description") {
                    TextEditor(text: $description)
                        .frame(height: 100)
                }
                Section("Completed for the last time") {
                    DatePicker("On:", selection: $lastCompleted)
                }
            }
            .navigationTitle("Add new activity")
            .toolbar {
                Button("Save") {
                    activities.items.append(Activity(name: name, description: description, lastCompleted: lastCompleted, completionCount: 0))
                    name = ""
                    description = ""
                    lastCompleted = Date()
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(activities: Activities())
    }
}
