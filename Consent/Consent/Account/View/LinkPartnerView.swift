//
//  LinkPartnerView.swift
//  Consent
//
//  Created by Lusine Magauzyan on 12.02.23.
//

import SwiftUI

struct LinkPartnerView: View {
    @EnvironmentObject private var store: AppStore

    @State private var isCopied = false
    @State private var partnerId = ""
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: UIScreen.main.bounds.width - 50, height: 350)
                .cornerRadius(16)
                .foregroundColor(Color(.systemCyan))
                .shadow(radius: 8)
            VStack {
                DescriptionText(title: "Your linkup code is", color: .white)
                ZStack {
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width - 120, height: 50)
                        .cornerRadius(16)
                        .foregroundColor(Color(.white))
                        .shadow(radius: 8)
                    HStack {
                        DescriptionText(title: store.state.currentUser?.uid ?? "N/A", color: .black)
                            .padding(.leading, 80)
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
                DescriptionText(title: "Copy and share it with your partner to link your accounts or type in your partner's code below and link", color: .white)
                    .padding(.leading, 40)
                    .padding(.trailing, 40)
                
                TextField("Your partner's code", text: $partnerId)
                    .padding()
                    .background(Color(.white))
                    .cornerRadius(16)
                    .frame(width: UIScreen.main.bounds.width - 120, height: 50)
                
                Button {
                    guard let currentUser = store.state.currentUser else { return }
                    FirebaseService.shared.link(currentUserId: currentUser.uid, partnerId: partnerId)
                    partnerId = ""
                } label: {
                    Text("Link")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
                .frame(width: 100, height: 40)
                .background(partnerId.isEmpty ? Color(.systemGray) : Color(.systemPink))
                .cornerRadius(8)
                .padding()
                .disabled(linkButtonDisabled())
                
            }
        }
    }
    
    private func linkButtonDisabled() -> Bool {
        guard let currentUser = store.state.currentUser else { return false }
        return partnerId.isEmpty || partnerId == currentUser.uid
    }
}


struct LinkPartnerView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
