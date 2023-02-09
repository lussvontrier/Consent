//
//  ExploreViewModel.swift
//  Consent
//
//  Created by Lusine Magauzyan on 01.02.23.
//

import SwiftUI
import FirebaseFirestore

class ExploreViewModel {

    func loadActivities(completion: @escaping ([Activity]) -> Void) {
        FirebaseService.shared.exploreActivities { result in
            switch result {
            case .success(let activities):
                completion(activities)
            case .failure(let error):
                print("\(error)")
            }
        }
    }
    
    func swipe(activity: Activity, right: Bool) {
        let db = Firestore.firestore()
        let userId = "QrcfMz0JXZPO3knJ8wc8"
        let swipeId = "\(userId)-\(activity.id)"
        db.collection("swipes")
            .document(swipeId)
            .setData([
                "userId": db.collection("users").document(userId),
                "activityId": db.collection("activities").document(activity.id),
                "swipedRight": right
            ]) { error in
                if let error {
                    print("Error: \(error)")
                } else {
                    print("Successfully swiped")
                }
            }
    }

    
}
