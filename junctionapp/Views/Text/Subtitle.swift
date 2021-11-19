//
//  Subtitle.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 19.11.2021.
//

import Foundation
import SwiftUI

struct Subtitle: View {
    let verbatim: String
    
    init(_ str: String) {
        self.verbatim = str
    }
    
    var body: some View {
        Text(verbatim).bold().fontSize(18).height(22)
    }
}
