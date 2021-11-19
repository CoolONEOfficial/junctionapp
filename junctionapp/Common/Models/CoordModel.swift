//
//  CoordModel.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 20.11.2021.
//

import Foundation
import MapKit

struct CoordModel: Codable, Equatable {
    let latitude: Double
    let longitude: Double
}

extension CoordModel {
    init(_ coord: CLLocationCoordinate2D) {
        self.init(latitude: coord.latitude, longitude: coord.longitude)
    }

    var coord: CLLocationCoordinate2D {
        .init(latitude: latitude, longitude: longitude)
    }
}
