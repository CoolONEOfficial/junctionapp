//
//  MainViewModel.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 19.11.2021.
//

import Foundation
import MapKit

class CityViewModel: ViewModel {
    @Published var houses: [HouseModel]?
    @Published var query = ""

    private let nw = NetworkService.shared

    var housesCenter: CLLocationCoordinate2D? {
        guard let houses = houses else {
            return nil
        }
        return houses.reduce(CLLocationCoordinate2D()) {
            let lat = $0.latitude + $1.coordinate.latitude / Double(houses.count)
            let lon = $0.longitude + $1.coordinate.longitude / Double(houses.count)
            return .init(latitude: lat, longitude: lon)
        }
    }
    
    @MainActor
    func update() async {
        notifications.isLoading = true
        defer { notifications.isLoading = false }

        do {
            houses = [
                .init(coordinate: .init(latitude: 40.7128, longitude: 74.0060)),
                .init(coordinate: .init(latitude: 37.7749, longitude: 122.4194)),
                .init(coordinate: .init(latitude: 47.6062, longitude: 122.3321))
            ]//try await nw.fetchData(.init(test: "test"))
        } catch {
            houses = nil
        }
    }
}
