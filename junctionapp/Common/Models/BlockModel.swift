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
    let ENERGY: ChartModel?
}

extension ChartWaterModel {
    static var mock: Self {
        .init(WATER_COLD: nil, WATER_HOT: nil, ENERGY: nil)
    }
}

struct BlockModel: Codable, Equatable, Identifiable {
    let charts: ChartWaterModel
    let id: Int64
    let name: String
    let sensors: [SensorModel]
}

extension BlockModel {
    static var mock: Self {
        .init(charts: .mock, id: .random, name: "", sensors: [])
    }
}
