//
//  CoordModel.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 20.11.2021.
//

import Foundation
import MapKit

struct CoordModel: Codable, Equatable {
    let lat: Double
    let lon: Double
}

extension CoordModel {
    init(_ coord: CLLocationCoordinate2D) {
        self.init(lat: coord.latitude, lon: coord.longitude)
    }

    var coord: CLLocationCoordinate2D {
        .init(latitude: lat, longitude: lon)
    }
}
