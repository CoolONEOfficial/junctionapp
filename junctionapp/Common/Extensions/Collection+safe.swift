//
//  Collection+safe.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 19.11.2021.
//

import Foundation

extension Collection {

    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index?) -> Element? {
        guard let index = index else { return nil }
        return indices.contains(index) ? self[index] : nil
    }
}
