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
    @State private var isShowingSortOptions = false
    @State private var searchText = "" // maybe later~
    @State private var sortingOrder: (Activity, Activity) -> Bool = {
        $0.name < $1.name
    }
  
    var body: some View {
        NavigationView {
            List {
                ForEach(activities.items.sorted(by: sortingOrder)) { item in
                    NavigationLink {
                        DetailsView(activities: activities, item: item)
                    } label: {
                        HStack {
                            Text(item.name)
                            Spacer()
                            Text("\(item.completionCount)")
                                .font(.caption.weight(.black))
                                .padding(5)
                                .frame(minWidth: 50)
                                .background(color(for: item))
                                .clipShape(Capsule())
                        }
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("Habit Tracking")
            .navigationBarItems(trailing:
                HStack {
                    Button {
                        isShowingSortOptions.toggle()
                    } label: {
                        Image(systemName: "arrow.up.arrow.down")
                    }
                    Button {
                        isShowingAddItem.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $isShowingAddItem) {
                        AddView(activities: activities)
                    }
                }
            )
            
            .confirmationDialog("Change sort order", isPresented: $isShowingSortOptions) {
                Button("Default") {
                    sortingOrder = {
                        $0.name < $1.name
                    }
                }
                Button("By completions") {
                    sortingOrder = {
                        $0.completionCount < $1.completionCount
                    }
                }
            }
                      
            Text("Welcome to the Habit Tracking App") //secondary view on wider screens - no bulshit in xcode output
                .font(.title)
        }
    }
    func removeItems(at offsets: IndexSet) {
        activities.items.remove(atOffsets: offsets)
    }
    
    func color(for activity: Activity) -> Color {
        if activity.completionCount < 3 {
            return .red
        } else if activity.completionCount < 10 {
            return .orange
        } else if activity.completionCount < 20 {
            return .green
        } else {
            return .blue
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
