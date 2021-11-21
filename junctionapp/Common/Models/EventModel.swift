//
//  EventModel.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 20.11.2021.
//

import Foundation

struct EventModel: Codable, Hashable {
    let id: Int64 = .random
    let name: String
    let sensorName: String
    let value: Double
    let blockName: String
    let count: Int?
    let isEcoFriendly: Bool?
    let dateTime: Date
    let message: String?
    let type: EventType = .faucet
}

enum EventType: String, Codable {
    case faucet
    case loundry
    case shower
    case washer
    
    var image: String {
        "Type\(rawValue.capitalizingFirstLetter())"
    }
}

extension EventModel: Identifiable {
}

extension EventModel {
    static var mock: Self {
        .init(name: "Name", sensorName: "sensor", value: 123, blockName: "Block name", count: 4, isEcoFriendly: true, dateTime: .now, message: "MEssage")
    }
}
