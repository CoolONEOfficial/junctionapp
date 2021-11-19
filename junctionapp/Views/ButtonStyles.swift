//
//  ButtonStyles.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 19.11.2021.
//

import Foundation
import SwiftUI
import SwiftUIX
import PureSwiftUI

struct BS {
    static let general = GeneralButtonStyle()
}

struct GeneralButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        RoundedRectangle(cornerRadius: 16).fill(.orange).overlay {
            configuration.label.foregroundColor(.text).font(.plain).fontSize(16)
        }.height(56).scaleEffect(configuration.isPressed ? 0.9 : 1)
    }
}
