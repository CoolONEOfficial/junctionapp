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
    let isEco: Bool?
    let isAnomaly: Bool?
    let dateTime: Date
    let message: String?
    let type: EventType
}

enum EventType: String, Codable {
    case DISHWASHER_COLD, DISHWASHER_HOT, ELECTRICITY, MIXER_COLD, MIXER_HOT, SHOWER_COLD, SHOWER_HOT, WASHER_COLD, WASHER_HOT
    
    
//    case faucet
//    case loundry
//    case shower
//    case washer
    
    var image: String {
        switch self {
        case .DISHWASHER_COLD, .DISHWASHER_HOT:
            return "TypeWasher"
        case .ELECTRICITY:
            return "TypeLoundry"
        case .MIXER_COLD, .MIXER_HOT:
            return "TypeFaucet"
        case .SHOWER_COLD, .SHOWER_HOT:
            return "TypeShower"
        case .WASHER_COLD, .WASHER_HOT:
            return "TypeLoundry"
        }
    }
}

extension EventModel: Identifiable {
}

extension EventModel {
    static var mock: Self {
        .init(name: "Name", sensorName: "sensor", value: 123, blockName: "Block name", count: 4, isEco: true, isAnomaly: nil, dateTime: .now, message: "MEssage", type: .ELECTRICITY)
    }
}
