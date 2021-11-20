//
//  Title.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 19.11.2021.
//

import SwiftUI

struct Title: View {
    let verbatim: String
    let weight: Font.Weight
    let color: Color?
    
    @EnvironmentObject var theme: Theme
    
    init(_ str: String, weight: Font.Weight = .bold, color: Color? = nil) {
        self.verbatim = str
        self.weight = weight
        self.color = color
    }

    var body: some View {
        Text(verbatim).foregroundColor(color ?? theme.text).fontWeight(weight).fontSize(20)
    }
}
