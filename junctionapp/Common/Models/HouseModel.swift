//
//  HouseModel.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 19.11.2021.
//

import Foundation

struct HouseModel: Codable {
    let id = UUID()
    let coordinate: CoordModel
}

extension HouseModel: Equatable {
}

extension HouseModel: MapPoint {
}
