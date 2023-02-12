//
//  AppState.swift
//  Consent
//
//  Created by Lusine Magauzyan on 08.02.23.
//

import Foundation
import Combine
import FirebaseAuth

struct World {
    var service = FirebaseService.shared
}

enum AppAction {
    case setExploreActivities(exploreActivities: [Activity])
    case removeFirstActivity
    case setCurrentUser(currentUser: User)
    case linkPartner(currentUser: User, partnerUserId: String)
}

struct AppState {
    var exploreActivities: [Activity] = []
    var currentUser: User?
    var partnerUserId: String?
    
    func index(activity: Activity) -> Int {
        let index = exploreActivities.firstIndex(where: {activity.id == $0.id}) ?? 0
        return index
    }
}

func appReducer(
    state: inout AppState,
    action: AppAction,
    environment: World
) -> AnyPublisher<AppAction, Never> {
    
    switch action {
    case let .setExploreActivities(activities):
        state.exploreActivities = activities
    case let .setCurrentUser(user):
        state.currentUser = user
        FirebaseService.shared.registerToFirebase(userId: user.uid)
    case let .linkPartner(user, partnerUserId):
        state.partnerUserId = partnerUserId
        FirebaseService.shared.link(currentUserId: user.uid, partnerId: partnerUserId)
    case .removeFirstActivity:
        state.exploreActivities.removeFirst()
        //    case let .search(query):
        //        return environment.service
        //            .searchPublisher(matching: query)
        //            .replaceError(with: [])
        //            .map { AppAction.setSearchResults(repos: $0) }
        //            .eraseToAnyPublisher()
//    case .fetchExploreActivities:
//        environment.service
//            .exploreActivitiesPublisher()
//            .replaceError(with: [])
//            .map { AppAction.setExploreActivities(activities: $0) }
//            .eraseToAnyPublisher()
    }
    
    return Empty().eraseToAnyPublisher()
}


