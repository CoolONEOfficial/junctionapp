//
//  MainViewModel.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 19.11.2021.
//

import Foundation
import MapKit
import Combine
import SwiftUI

class CityViewModel: ViewModel {
    @Published var houses: [HouseModel]?
    @Published var query = ""
    @Published var selectedSections = Set<Int>()
    
    @Published var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    @Published var markerUp = false
    @Published var markerLocation: CoordModel?
    @Published var markerPosition: String = ""
    
    @Published var eventSheet: EventModel? = .init(name: "Name", sensorName: "Secson", value: 123, clusterName: "Cluster", count: 3, isEcoFriendly: false)
    
    func didChangeMarkerLocation() {
        guard let coord = markerLocation?.coord else { return }
        let address = CLGeocoder.init()
        address.reverseGeocodeLocation(.init(latitude: coord.latitude, longitude: coord.longitude)) { (places, error) in
            if error == nil{
                if let place = places?.first?.postalAddress {
                    withAnimation {
                        self.markerPosition = [place.city, place.street].compactMap { $0 }.joined(separator: ", ")
                    }
                }
            }
        }
    }
    
    private let nw = NetworkService.shared

    private var subscriptions = Set<AnyCancellable>()
        
    override init() {
        super.init()
        
        $region
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .sink(receiveValue: { t in
                withAnimation {
                    self.markerUp = false
                    self.didChangeMarkerLocation()
                }
            } )
            .store(in: &subscriptions)
    }
    
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
            notifications.alert = "Oops, error!"
            houses = nil
        }
    }

    func search(_ coord: CoordModel) {
        
    }
}
