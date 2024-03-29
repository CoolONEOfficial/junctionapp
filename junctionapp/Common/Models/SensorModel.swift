//
//  SensorModel.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 20.11.2021.
//

import Foundation

struct SensorModel: Codable, Identifiable, Equatable {
    let charts: ChartWaterModel
    let id: Int64
    let name: String
}

extension SensorModel {
    static var mock: Self {
        .init(charts: .init(WATER_COLD: nil, WATER_HOT: nil, ENERGY: nil), id: .random, name: "")
    }
}
