//
//  ExploreView.swift
//  Consent
//
//  Created by Lusine Magauzyan on 01.02.23.
//

import SwiftUI
import FirebaseFirestore

struct ExploreView: View {
    @EnvironmentObject private var store: AppStore
    private var viewModel = ExploreViewModel()
    
    var body: some View {
        
        //MARK: Top Menu
        VStack {
            HStack {
                Text("Explore")
                    .font(.title.bold())
            }
            
            //MARK: Activity Cards
            ZStack {
                if let activities = store.state.exploreActivities {
                    if activities.isEmpty {
                        Text("You're out of cards options. Please subscribe to PRO to get more options.")
                            .font(.title)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    } else {
                        ForEach(activities.reversed()) { activity in
                            ActivityCardView(activity: activity)
                                .environmentObject(viewModel)
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
            .onAppear {
                viewModel.loadActivities { activities in
                    store.send(.setExploreActivities(exploreActivities: activities))
                }
            }
            
//            //MARK: Action Buttons
//            HStack(spacing: 30) {
//                SwipeActionButton(imageName: "xmark", backgroundColor: Color(.systemPink))
//                
//                SwipeActionButton(imageName: "suit.heart.fill", backgroundColor: Color(.systemMint))
//            }
//            .padding(.bottom)
//            .disabled(exploreData.displayableActivities?.isEmpty ?? false)
//            .opacity((exploreData.displayableActivities?.isEmpty ?? false) ? 0.6 : 1)
        }
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
