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
                FirebaseService.shared.signInAnonymously { result in
                    switch result {
                    case .success(let user):
                        store.send(.setCurrentUser(currentUser: user))
                    case .failure(let error):
                        print("\(error)")
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
