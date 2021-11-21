//
//  String+capitalizing.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 21.11.2021.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
