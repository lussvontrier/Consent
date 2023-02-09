//
//  ConsentTabView.swift
//  Consent
//
//  Created by Lusine Magauzyan on 09.02.23.
//

import SwiftUI

struct ConsentTabView: View {
    
    @State private var selectedTab: Int = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            ExploreView()
                .tabItem {
                    Image(systemName: "rectangle.portrait.on.rectangle.portrait.angled")
                    Text("Explore")
                }
                .tag(0)
            
            MatchesView()
                .tabItem {
                    Image(systemName: "flame")
                    Text("Matches")
                }
                .tag(1)
            
            ExploreView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Account")
                }
                .tag(2)
        }
        .accentColor(Color(.systemPurple))
    }
}

struct ConsentTabView_Previews: PreviewProvider {
    static var previews: some View {
        ConsentTabView()
    }
}
