//
//  FirebaseService.swift
//  Consent
//
//  Created by Lusine Magauzyan on 09.02.23.
//

import Foundation
import FirebaseFirestore
import Combine

class FirebaseService {
    
    static let shared = FirebaseService()
    
    private init() { }
    
    func exploreActivities(completion: @escaping (Result<[Activity], Error>) -> Void) {
        
            Firestore.firestore().collection("activities").getDocuments { snapshot, error in
                if let error {
                    completion(.failure(error))
                } else if let snapshot {
                    var fetchedActivities: [Activity] = []
                    snapshot.documentChanges.forEach({ change in
                        switch change.type {
                        case .added:
                            let activity = Activity(fromId: change.document.documentID, andFirestoreObject: change.document.data())
                            fetchedActivities.append(activity)
                        case .modified:
                            print("")
                        case .removed:
                            print("")
                        }
                    })
                    completion(.success(fetchedActivities))
                }
            }
        }
    
    
    
    
    
}
