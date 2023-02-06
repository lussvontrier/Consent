//
//  MatchesView.swift
//  Consent
//
//  Created by Lusine Magauzyan on 03.02.23.
//

import SwiftUI

struct MatchesView: View {
    @StateObject private var matchesData = MatchesViewModel()

    var body: some View {
        VStack {
            HStack {
                Text("Matches")
                    .font(.title.bold())
            }
            if let matched = matchesData.matchedActivities {
                if matched.isEmpty {
                    Text("You don't have matched activities with your partner yet.")
                        .font(.title)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                } else {
                    List(matched) { item in
                        MatchesListView(activity: item)
                    }
                }
            } else {
                ProgressView()
            }
        }
    }
}

struct MatchesView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
