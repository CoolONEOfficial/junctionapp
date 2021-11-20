//
//  Caption.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 19.11.2021.
//

import Foundation
import SwiftUI
import SwiftUIX

struct Caption: View {
    @EnvironmentObject var theme: Theme
    
    let verbatim: String
    var isSelected = false

    init(_ str: String, isSelected: Bool = false) {
        self.verbatim = str
        self.isSelected = isSelected
    }

    var body: some View {
        Text(verbatim)
            .scaleEffect(isSelected ? 1.2 : 1)
            .foregroundColor(isSelected ? theme.textAccent : theme.secondaryText)
            .fontSize(13)
    }
}
