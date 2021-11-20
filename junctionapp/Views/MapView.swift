//
//  MapView.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 19.11.2021.
//

import SwiftUI
import MapKit

protocol MapPoint: Identifiable {
    var coordinate: CoordModel { get }
}

//struct MapView<T: MapPoint>: View {
//    @Binding var region: MKCoordinateRegion
//    @Binding var points: [T]
//
//    var didSelectPoint: (T) -> Void
//
//    var body: some View {
//        Map(coordinateRegion: $region,
//            interactionModes: MapInteractionModes.all,
//            showsUserLocation: true, annotationItems: points) { city in
//            MapAnnotation(
//                coordinate: city.coordinate.coord,
//                anchorPoint: CGPoint(x: 0.5, y: 0.5)
//            ) {
//                Circle()
//                    .stroke(Color.green)
//                    .frame(width: 44, height: 44)
//            }
//        }
//    }
//}

struct MapView<T: MapPoint>: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    @Binding var points: [T]
    @Binding var markerCoord: CoordModel?

    var markerOffset: CGFloat
    
    let mapView = MKMapView()
    
    func makeUIView(context: Context) -> MKMapView {
        mapView.delegate = context.coordinator
        mapView.mapType = .mutedStandard
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        //print(#function)
        mapView.region = region
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate, UIGestureRecognizerDelegate {
        var parent: MapView
        
        var gRecognizer = UITapGestureRecognizer()
        
        init(_ parent: MapView) {
            self.parent = parent
            super.init()
            self.gRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
            self.gRecognizer.delegate = self
            self.parent.mapView.addGestureRecognizer(gRecognizer)
        }
        
        @objc func tapHandler(_ gesture: UITapGestureRecognizer) {
           
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            parent.region = mapView.region
            let location = CGPoint((UIScreen.screens.first?.width ?? 0) / 2, (UIScreen.screens.first?.size.height ?? 0) / 2 + parent.markerOffset)
            let coord = self.parent.mapView.convert(location, toCoordinateFrom: self.parent.mapView)
            parent.markerCoord = .init(coord)
        }
    }
}

//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView()
//    }
//}
