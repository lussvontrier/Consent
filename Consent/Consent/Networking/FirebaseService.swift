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

    private let db = Firestore.firestore()
    
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
    
//    func registerToFirebase(userId: String) {
//        let db = Firestore.firestore()
//        db.collection("users")
//            .document(userId)
//            .setData([
//                "name": "Test"
//            ]) { error in
//                if let error {
//                    print("Error: \(error)")
//                } else {
//                    print("Successfully swiped")
//                }
//            }
//    }

    //MARK: Get explore activities
    func exploreActivities(completion: @escaping (Result<[Activity], Error>) -> Void) {
        
        db.collection("activities").getDocuments { snapshot, error in
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
    
    //MARK: Link partner
    func link(currentUserId: String, partnerId: String) {
        
        db.collection("users")
            .document(currentUserId)
            .setData([
                "partnerId": partnerId
            ]) { error in
                if let error {
                    print("Error: \(error)")
                } else {
                    print("Successfully swiped")
                }
            }
        
        db.collection("users")
            .document(partnerId)
            .setData([
                "partnerId": currentUserId
            ]) { error in
                if let error {
                    print("Error: \(error)")
                } else {
                    print("Successfully swiped")
                }
            }
    }
    
    func unLink(currentUserId: String, partnerId: String) {

        db.collection("users").document(currentUserId).updateData([
            "partnerId": FieldValue.delete(),
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
        
        db.collection("users").document(partnerId).updateData([
            "partnerId": FieldValue.delete(),
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    func addLinkListener(currentUserId: String, completion: @escaping (String?) -> Void) {

        db.collection("users").document(currentUserId)
            .addSnapshotListener { documentSnapshot, error in
                guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }
                print("document: \(document)")
                if let partnerId = document.get("partnerId") as? String {
                    completion(partnerId)
                } else {
                    completion(nil)
                }

            }
    }
    
    
    
    
    
    
}
