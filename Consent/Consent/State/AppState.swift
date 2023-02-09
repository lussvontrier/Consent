//
//  AppState.swift
//  Consent
//
//  Created by Lusine Magauzyan on 08.02.23.
//

import Foundation
import Combine

struct World {
    var service = FirebaseService.shared
}

enum AppAction {
    case setExploreActivities(activities: [Activity])
}

struct AppState {
    var exploreActivities: [Activity] = []
    
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


