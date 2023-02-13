//
//  ContentView.swift
//  Consent
//
//  Created by Lusine Magauzyan on 01.02.23.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    let store = Store(initialState: .init(), reducer: appReducer, environment: World())

    var body: some View {
        ConsentTabView()
            .environmentObject(store)
            .onAppear {
                if let currentUser = store.state.currentUser {
                    FirebaseService.shared.addLinkListener(currentUserId: currentUser.uid) { partnerId in
                        store.send(.setPartnerId(partnerId: partnerId))
                    }
                } else {
                    FirebaseService.shared.signInAnonymously { result in
                        switch result {
                        case .success(let user):
                            store.send(.setCurrentUser(currentUser: user))
                            
                            FirebaseService.shared.addLinkListener(currentUserId: user.uid) { partnerId in
                                store.send(.setPartnerId(partnerId: partnerId))
                            }
                        case .failure(let error):
                            print("\(error)")
                        }
                    }
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
