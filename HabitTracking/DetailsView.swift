//
//  Details.swift
//  HabitTracking
//
//  Created by Alex Po on 26.05.2022.
//

import SwiftUI

struct DetailsView: View {
    @ObservedObject var activities: Activities
    var item: Activity
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("\(item.description)")
                    .font(.headline)
                Text("This activity was completed for the last time on \(item.lastCompleted)." )
                    .padding(.top)
                Text("Total number of completions: \(item.completionCount)")
                    .padding(.top)
                Button {
                    addCompletion()
                } label: {
                    Text("Add completion")
                        .font(.title2)
                        .padding(.top)
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("\(item.name) details")
            .navigationViewStyle(.stack) // stops xcode warnings
        }
    }
    
    func addCompletion() {
        var newActivity = item
        newActivity.lastCompleted = Date()
        newActivity.completionCount += 1
        if let index = activities.items.firstIndex(of: item) {
            activities.items[index] = newActivity
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(activities: Activities(), item: Activities().items[0])
    }
}
