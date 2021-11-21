//
//  BuildingModel.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 20.11.2021.
//

import Foundation

struct BuildingModel: Codable, Identifiable, Equatable {
    let id: Int64
    let name: String
    let point: CoordModel?
    let blocks: [BlockModel]
    let charts: ChartWaterModel
}

extension BuildingModel {
    static var mock: Self {
        .init(id: .random, name: "", point: nil, blocks: [], charts: .mock)
    }
}
