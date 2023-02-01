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
            Activity(name: "Bondage", color: .blue),
            Activity(name: "Kissing", color: .cyan),
            Activity(name: "Oral", color: .indigo),
            Activity(name: "Spanking", color: .purple),
            Activity(name: "Handcuffs", color: .orange),
            Activity(name: "Missionary", color: .teal),
            Activity(name: "SixtyNine", color: .yellow)
        ]
        
        displayableActivities = fetchedActivities
    }
    
    func index(activity: Activity) -> Int {
        let index = displayableActivities?.firstIndex(where: {activity.id == $0.id}) ?? 0
        return index
    }
    
}
