//
//  ContentView.swift
//  HabitTracking
//
//  Created by Alex Po on 26.05.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var activities = Activities()
    @State private var isShowingAddItem = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(activities.items) { item in
                    NavigationLink {
                        DetailsView(activities: activities, item: item)
                    } label: {
                        Text(item.name)
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("Habit Tracking")
            .toolbar {
                Button {
                    isShowingAddItem.toggle()
                } label: {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $isShowingAddItem) {
                    AddView(activities: activities)
                }
            }
            Text("Welcome to the Habbit Tracking App") //secondary view on whider screens
                .font(.title)
        }
    }
    func removeItems(at offsets: IndexSet) {
        activities.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
