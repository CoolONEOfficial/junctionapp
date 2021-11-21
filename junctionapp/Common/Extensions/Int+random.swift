//
//  Int+random.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 20.11.2021.
//

import Foundation

extension Int64 {
    static var random: Self {
        .random(in: Self.min..<Self.max)
    }
}
