//
//  MatchesListView.swift
//  Consent
//
//  Created by Lusine Magauzyan on 06.02.23.
//

import SwiftUI

struct MatchesListView: View {
    var activity: Activity
    
    var body: some View {
        
        ZStack {
            let width = UIScreen.main.bounds.width - 50
            Rectangle()
                .frame(width: width, height: 80)
                .cornerRadius(16)
                .foregroundColor(Color(.systemCyan))
                .shadow(radius: 8)
            
            HStack(spacing: 20) {
                
                Image("menu")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 50)
                    .cornerRadius(4)
                
                Text(activity.name)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
                    .foregroundColor(.white)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 35)
        }
    }
}

struct MatchesListView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
