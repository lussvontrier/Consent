//
//  ExploreViewModel.swift
//  Consent
//
//  Created by Lusine Magauzyan on 01.02.23.
//

import SwiftUI

class ExploreViewModel: ObservableObject {
    @Published var fetchedActivities: [Activity] = []
    @Published var displayableActivities: [Activity]?
    
    init() {
        fetchedActivities = [
            Activity(name: "One", color: .blue),
            Activity(name: "Two", color: .cyan),
            Activity(name: "Three", color: .indigo),
            Activity(name: "Four", color: .purple),
            Activity(name: "Five", color: .orange),
            Activity(name: "Six", color: .teal),
            Activity(name: "Seven", color: .yellow)
        ]
        
        displayableActivities = fetchedActivities
    }
    
    func index(activity: Activity) -> Int {
        let index = displayableActivities?.firstIndex(where: {activity.id == $0.id}) ?? 0
        return index
    }
    
}
