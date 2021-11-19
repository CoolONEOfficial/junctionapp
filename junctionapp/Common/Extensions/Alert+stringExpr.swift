//
//  Alert+stringExpr.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 19.11.2021.
//

import Foundation
import SwiftUI

extension Alert: ExpressibleByStringLiteral {
    public typealias StringLiteralType = String
    
    public init(stringLiteral value: StringLiteralType) {
        self.init(title: Text(value), message: nil, dismissButton: nil)
    }
}
