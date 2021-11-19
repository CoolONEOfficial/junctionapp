//
//  ActivityIndicator.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 19.11.2021.
//

import Foundation
import SwiftUI
import SwiftUIX

struct ActivityIndicator: View {
    var isLoading: Bool
    @EnvironmentObject var theme: Theme
    
    @ViewBuilder
    var body: some View {
        if isLoading {
            SwiftUIX.ActivityIndicator().style(.large).tintColor(theme.accent.toUIColor()).animated(true).background(Color.clear).fill()
        }
    }
}
