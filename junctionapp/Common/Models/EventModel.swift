//
//  EventModel.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 20.11.2021.
//

import Foundation

struct EventModel: Codable, Hashable {
    let name: String
    let sensorName: String
    let value: Int
    let clusterName: String
    let count: Int
    let isEcoFriendly: Bool
}

extension EventModel: Identifiable {
    var id: Int {
        hashValue
    }
}
