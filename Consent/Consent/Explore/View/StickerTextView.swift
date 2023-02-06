//
//  StickerTextView.swift
//  Consent
//
//  Created by Lusine Magauzyan on 03.02.23.
//

import SwiftUI

struct StickerTextView: View {
    let text: String
    let degrees: Double
    let color: Color
    let offset: CGSize
    let multiplier: Double
    
    var body: some View {
        Text(text)
            .padding()
            .font(.title)
            .rotationEffect(.degrees(degrees))
            .foregroundColor(color)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(color, lineWidth: 4)
                    .rotationEffect(.degrees(degrees))
            )
            .opacity(Double(offset.width/(UIScreen.main.bounds.width-300) * multiplier))
    }
}

struct StickerTextView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
