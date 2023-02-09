//
//  Activity.swift
//  Consent
//
//  Created by Lusine Magauzyan on 01.02.23.
//

import SwiftUI

struct Activity: Identifiable {
    var id: String
    var name: String
}

extension Activity {
    init(fromId id: String, andFirestoreObject obj: [String: Any]) {
        self.id = id
        self.name = obj["name"] as! String
    }
}
