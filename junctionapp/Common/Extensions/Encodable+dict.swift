//
//  Encodable+dict.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 19.11.2021.
//

import Foundation

extension Encodable {
    var dict: [String: Any] {
        let data = try! JSONEncoder().encode(self)
        let dictionary = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
        return dictionary
    }
}
