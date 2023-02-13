//
//  LinkedPartnerView.swift
//  Consent
//
//  Created by Lusine Magauzyan on 12.02.23.
//

import SwiftUI

struct LinkedPartnerView: View {
    @EnvironmentObject private var store: AppStore
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: UIScreen.main.bounds.width - 50, height: 190)
                .cornerRadius(16)
                .foregroundColor(Color(.systemCyan))
                .shadow(radius: 8)
            VStack {
                DescriptionText(title: "You are linked to", color: .white)
                ZStack {
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width - 120, height: 50)
                        .cornerRadius(16)
                        .foregroundColor(Color(.white))
                        .shadow(radius: 8)
                    HStack {
                        DescriptionText(title: store.state.partnerId ?? "N/A", color: .black)
                    }
                }
                
                Button {
                    guard let currentUser = store.state.currentUser else { return }
                    guard let partnerId = store.state.partnerId else { return }
                    FirebaseService.shared.unLink(currentUserId: currentUser.uid, partnerId: partnerId)
                    
                } label: {
                    Text("Unlink")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
                .frame(width: 100, height: 40)
                .background(Color(.systemPink))
                .cornerRadius(8)
                .padding()
                
            }
        }
    }
}

struct LinkedPartnerView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
