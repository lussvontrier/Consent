//
//  Texts.swift
//  Consent
//
//  Created by Lusine Magauzyan on 12.02.23.
//

import SwiftUI

struct TabTitle: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.title.bold())
    }
}

struct Texts_Previews: PreviewProvider {
    static var previews: some View {
        TabTitle(title: "Account")
    }
}
