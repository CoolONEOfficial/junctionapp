//
//  Title.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 19.11.2021.
//

import SwiftUI

struct Title: View {
    let verbatim: String
    
    @EnvironmentObject var theme: Theme
    
    init(_ str: String) {
        self.verbatim = str
    }
    
    var body: some View {
        Text(verbatim).foregroundColor(theme.text).bold().fontSize(24).height(29)
    }
}
