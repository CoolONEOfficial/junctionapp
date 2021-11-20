//
//  BlockModel.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 20.11.2021.
//

import Foundation

struct ChartWaterModel: Codable, Equatable {
    let WATER_COLD: ChartModel?
    let WATER_HOT: ChartModel?
}

struct BlockModel: Codable, Equatable, Identifiable {
    let charts: ChartWaterModel
    let id: Int
    let name: String
    let sensors: [SensorModel]
}

extension BlockModel {
    static var mock: Self {
        .init(charts: .init(WATER_COLD: nil, WATER_HOT: nil), id: .random, name: "", sensors: [])
    }
}
