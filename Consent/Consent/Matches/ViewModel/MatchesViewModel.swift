//
//  MatchesViewModel.swift
//  Consent
//
//  Created by Lusine Magauzyan on 06.02.23.
//

import SwiftUI

class MatchesViewModel: ObservableObject {
    @Published var matchedActivities: [Activity]?
    
    init() {
        matchedActivities = [
            Activity(name: "One", color: .blue),
            Activity(name: "Two", color: .cyan),
            Activity(name: "Three", color: .indigo),
            Activity(name: "Four", color: .purple),
            Activity(name: "Five", color: .orange),
            Activity(name: "Six", color: .teal),
            Activity(name: "Seven", color: .yellow)
        ]
    }
    
}

