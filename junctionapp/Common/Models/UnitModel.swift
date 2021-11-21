//
//  UnitModel.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 20.11.2021.
//

import Foundation

enum UnitModel: String, Codable, CaseIterable {
    case kwtPerHour = "KWT_PER_HOUR"
    case liters = "LITERS"
    case euro = "EURO"
    
    var name: String {
        switch self {
        case .kwtPerHour:
            return "kWh"
        case .liters:
            return "ml"
        case .euro:
            return "€"
        }
    }
}
