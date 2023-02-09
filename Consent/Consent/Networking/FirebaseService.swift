//
//  FirebaseService.swift
//  Consent
//
//  Created by Lusine Magauzyan on 09.02.23.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import Combine

class FirebaseService {
    
    //MARK: Init
    static let shared = FirebaseService()
    private init() { }
    
    //MARK: Sign in
    func signInAnonymously(completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signInAnonymously { authResult, error in
            if let user = authResult?.user {
                completion(.success(user))
            } else if let error {
                completion(.failure(error))
            }
        }
    }

    
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
