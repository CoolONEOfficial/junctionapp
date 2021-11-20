//
//  View+skeleton.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 20.11.2021.
//

import Foundation
import SwiftUI

extension View {
    func skelet(_ bool: Bool) -> some View {
        self
            .skeleton(with: bool)
            .animation(type: .pulse())
            .shape(type: .rectangle)
    }
}
