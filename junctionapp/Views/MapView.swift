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

struct MapView<T: MapPoint>: View {
    @Binding var region: MKCoordinateRegion
    @Binding var points: [T]

    var didSelectPoint: (T) -> Void

    var body: some View {
        Map(coordinateRegion: $region,
            interactionModes: MapInteractionModes.all,
            showsUserLocation: true, annotationItems: points) { city in
            MapAnnotation(
                coordinate: city.coordinate.coord,
                anchorPoint: CGPoint(x: 0.5, y: 0.5)
            ) {
                Circle()
                    .stroke(Color.green)
                    .frame(width: 44, height: 44)
            }
        }
    }
}

//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView()
//    }
//}
