//
//  NetworkService+buildings.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 20.11.2021.
//

import Foundation
import Alamofire

struct BuildingsResponse: Codable {
    struct Total: Codable {
        enum SensorGroup: String, Codable {
            case energy = "ENERGY"
            case waterCold = "WATER_COLD"
            case waterHot = "WATER_HOT"
        }
        let sensorGroup: SensorGroup
        
        let unit: UnitModel
        
        let values: Double
    }
    let buildings: [BuildingModel]
    let totals: [Total]
}

extension NetworkService {
    struct BuildingsParams: Codable {
        let from: Date
        let to: Date
    }

    func fetchBuildings(_ req: BuildingsParams, types: Set<SectionType>) async throws -> BuildingsResponse {
        var lastComp = ""
        
        if types.count == 1 {
            switch types.first {
            case .water: lastComp = "/water"
            case .energy: lastComp = "/energy"
            default: break
            }
        }

        return try await AF.request(apiBase + "/buildings/data\(lastComp)?from=\(dateFormatter.string(from: req.from))&to=\(dateFormatter.string(from: req.to))", parameters: req.dict).responseDecodable(of: BuildingsResponse.self, decoder: jsonDecoder)
    }
}
