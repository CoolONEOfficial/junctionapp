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
import SwiftDate

class CityViewModel: ViewModel {
    @Published var houses: [HouseModel]?
    @Published var buildings: BuildingsResponse?
    @Published var query = ""
    @Published var selectedSections = Set<Int>() {
        didSet {
            if oldValue.count > selectedSections.count {
                withAnimation {
                    selectedBlock = nil
                }
            } else {
                refreshBuildings()
            }
        }
    }
    @Published var datePicker = false
    @Published var startDate = (DateInRegion("2021-10-01T00:00:00+0000")!).date {
        didSet {
            refreshBuildings()
        }
    }
    @Published var endDate = (DateInRegion("2021-11-01T00:00:00+0000")!).date {
        didSet {
            refreshBuildings()
        }
    }

    var selectedSectionsEnum: Set<SectionType> {
        .init(selectedSections.map { SectionType.allCases[$0] })
    }
    
    @Published var selectedBlock: BlockModel? {
        didSet {
            withAnimation {
                selectedSensor = nil
            }
        }
    }
    @Published var selectedSensor: SensorModel? {
        didSet {
            refreshBuildings()
        }
    }
    
    @Published var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    @Published var markerUp = false
    @Published var markerLocation: CoordModel?
    @Published var markerPosition: String = ""
    
    @Published var eventSheet: EventModel? //= .init(name: "Name", sensorName: "Secson", value: 123, clusterName: "Cluster", count: 3, isEcoFriendly: false)
    
    private let nw = NetworkService.shared
    private var subscriptions = Set<AnyCancellable>()

    var buildingsRefresh: Task<Any, Error>?

    func refreshBuildings() {
        buildingsRefresh?.cancel()
        buildingsRefresh = Task {
            defer { buildingsRefresh = nil }
            return await fetchBuildings()
        }
    }

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
    
    @MainActor
    func fetchBuildings() async {
//        withAnimation {
//            notifications.isLoading = true
//        }
//        defer {
//            withAnimation {
//                notifications.isLoading = false
//            }
//        }

        let req = NetworkService.BuildingsParams(from: startDate, to: endDate)
        do {
            let buildings = try await nw.fetchBuildings(req, types: selectedSectionsEnum)
            withAnimation {
                self.buildings = buildings
            }
        } catch {
            let test = error
            debugPrint("error \(error)")
            notifications.alert = "Oops, error!"
            houses = nil
        }
    }

    func search(_ coord: CoordModel) {
        
    }
    
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
}

//    var housesCenter: CLLocationCoordinate2D? {
//        guard let houses = houses else {
//            return nil
//        }
//        return houses.reduce(CLLocationCoordinate2D()) {
//            let lat = $0.latitude + $1.coordinate.latitude / Double(houses.count)
//            let lon = $0.longitude + $1.coordinate.longitude / Double(houses.count)
//            return .init(latitude: lat, longitude: lon)
//        }
//    }
