//
//  SwipeActionButton.swift
//  Consent
//
//  Created by Lusine Magauzyan on 03.02.23.
//

import SwiftUI

struct SwipeActionButton: View {
    let imageName: String //"suit.heart.fill"
    let backgroundColor: Color //Color(.systemMint)
    
    var body: some View {
        Button {
            
        } label: {
            Image(systemName: imageName)
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(.white)
                .shadow(radius: 5)
                .padding(15)
                .background(backgroundColor)
                .clipShape(Circle())
        }
    }
}

struct SwipeActionButton_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
