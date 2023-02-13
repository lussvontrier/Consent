//
//  AccountView.swift
//  Consent
//
//  Created by Lusine Magauzyan on 10.02.23.
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject private var store: AppStore

    var body: some View {
        VStack {
            HStack {
                TabTitle(title: "Account")
            }
            if let _ = store.state.partnerId {
                LinkedPartnerView()
            } else {
                LinkPartnerView()
            }
            Spacer()
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

