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
    @Environment(\.dismiss) var dismiss
    
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
                    let trimmedName = name.trimmingCharacters(in: .whitespaces)
                    guard !trimmedName.isEmpty else {return}
                                        
                    activities.items.append(Activity(name: trimmedName, description: description, lastCompleted: lastCompleted))
                    dismiss()
                }
            }
            .navigationViewStyle(.stack) //stops xcode warnings
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(activities: Activities())
    }
}
