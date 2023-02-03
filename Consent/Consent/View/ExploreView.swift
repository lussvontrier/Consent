//
//  ExploreView.swift
//  Consent
//
//  Created by Lusine Magauzyan on 01.02.23.
//

import SwiftUI

struct ExploreView: View {
    @StateObject private var exploreData = ExploreViewModel()
    
    var body: some View {
        
        //MARK: Top Menu
        VStack {
            Button {
                
            } label: {
                Image(ImageNames.Icons.menu)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .overlay(
                Text("Discover")
                    .font(.title.bold())
            )
            .foregroundColor(.black)
            .padding()
            
            //MARK: Activity Cards
            ZStack {
                if let activities = exploreData.displayableActivities {
                    if activities.isEmpty {
                        Text("You're out of cards options. Please subscribe to PRO to get more options.")
                            .font(.title)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    } else {
                        ForEach(activities.reversed()) { activity in
                            ActivityCardView(activity: activity)
                                .environmentObject(exploreData)
                                
                        }
                    }
                } else {
                    ProgressView()
                }
            }
            .zIndex(1)
            .padding()
            .padding(.vertical)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            //MARK: Action Buttons
            HStack(spacing: 30) {
                SwipeActionButton(imageName: "xmark", backgroundColor: Color(.systemPink))
                
                SwipeActionButton(imageName: "suit.heart.fill", backgroundColor: Color(.systemMint))
            }
            .padding(.bottom)
            .disabled(exploreData.displayableActivities?.isEmpty ?? false)
            .opacity((exploreData.displayableActivities?.isEmpty ?? false) ? 0.6 : 1)
        }
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
