//
//  Int+random.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 20.11.2021.
//

import Foundation

extension Int {
    static var random: Int {
        .random(in: Int.min..<Int.max)
    }
}
