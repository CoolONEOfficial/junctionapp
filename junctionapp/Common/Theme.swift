//
//  Theme.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 19.11.2021.
//

import Foundation
import SwiftUI
import DynamicColor

class Theme: ObservableObject {
    @Published var accent: Color
    @Published var text: Color
    @Published var secondaryText: Color
    @Published var textAccent: Color
    @Published var primary: Color
    @Published var secondary: Color

    init(primary: Color = .primary,
         accent: Color  = .accent,
         text: Color = .text,
         textAccent: Color = .textAccent,
         secondaryText: Color = .secondaryText,
         secondary: Color = .secondary) {
        self.accent = accent
        self.text = text
        self.textAccent = textAccent
        self.secondaryText = secondaryText
        self.primary = primary
        self.secondary = secondary
    }
}
