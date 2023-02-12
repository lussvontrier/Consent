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
//            if store.state.partnerUserId == "" {
                LinkPartnerView()
//            } else {
//                Text("You are connected to")
//            }
            Spacer()
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct LinkPartnerView: View {
    @EnvironmentObject private var store: AppStore

    @State private var isCopied = false
    @State private var partnerCode = ""
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: UIScreen.main.bounds.width - 50, height: 350)
                .cornerRadius(16)
                .foregroundColor(Color(.systemCyan))
                .shadow(radius: 8)
            VStack {
                Text("Your linkup code is")
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
                    .foregroundColor(.white)
                ZStack {
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width - 120, height: 50)
                        .cornerRadius(16)
                        .foregroundColor(Color(.white))
                        .shadow(radius: 8)
                    HStack {
                        Text(store.state.currentUser?.uid ?? "N/A")
                            .font(.subheadline)
                            .padding(.leading, 80)
                            .multilineTextAlignment(.center)
                            .onTapGesture(count: 2) {
                                UIPasteboard.general.string = store.state.currentUser?.uid ?? "N/A"
                            }
                        Button {
                            UIPasteboard.general.string = store.state.currentUser?.uid ?? "N/A"
                            isCopied = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                isCopied = false
                            }
                        } label: {
                            Image(systemName: isCopied ? "checkmark" : "doc.on.doc.fill")
                                .font(.system(size: 15, weight: .bold))
                                .foregroundColor(.white)
                                .shadow(radius: 5)
                                .padding(5)
                                .background(isCopied ? Color(.systemGreen) : Color(.systemPink))
                                .clipShape(Circle())
                                .frame(width: 20, height: 20)
                        }
                        .padding(.trailing, 70)
                        .disabled(isCopied)
                    }
                }
                Text("Copy and share it with your partner to link your accounts or type in your partner's code below and link")
                    .fontWeight(.semibold)
                    .minimumScaleFactor(0.5)
                    .foregroundColor(.white)
                    .padding(.leading, 40)
                    .padding(.trailing, 40)
                    .multilineTextAlignment(.center)
                
                TextField("Your partner's code", text: $partnerCode)
                    .padding()
                    .background(Color(.white))
                    .cornerRadius(16)
                    .frame(width: UIScreen.main.bounds.width - 120, height: 50)
                
                Button {
                    guard let currentUser = store.state.currentUser else { return }
                    store.send(.linkPartner(currentUser: currentUser, partnerUserId: partnerCode))
                    partnerCode = ""
                } label: {
                    Text("Link")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
                .frame(width: 100, height: 40)
                .background(partnerCode.isEmpty ? Color(.systemGray) : Color(.systemPink))
                .cornerRadius(8)
                .padding()
                .disabled(linkButtonDisabled())
                
            }
        }
    }
    
    private func linkButtonDisabled() -> Bool {
        guard let currentUser = store.state.currentUser else { return false }
        return partnerCode.isEmpty || partnerCode == currentUser.uid
    }
}
