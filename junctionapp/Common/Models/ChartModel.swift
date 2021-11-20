//
//  ChartModel.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 20.11.2021.
//

import Foundation

struct ChartModel: Codable, Equatable {
    struct Item: Codable, Equatable {
        let date: Date
        let value: Double
    }
    
    let threshold: Double
    let data: [Item]
}
