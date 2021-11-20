//
//  CityView.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 19.11.2021.
//

import SwiftUI
import SwiftUIX
import MapKit
import PureSwiftUI
import DynamicColor
import LightChart
import Snap

extension MKCoordinateRegion: Equatable {
    public static func == (lhs: MKCoordinateRegion, rhs: MKCoordinateRegion) -> Bool {
        lhs.center == rhs.center
    }
}

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

struct CityView: View {
    @EnvironmentObject var theme: Theme
    @StateObject var viewModel: CityViewModel
    
    @State var state: Snap.AppleMapsSnapState = .medium
    @Environment(\.safeAreaInsets) private var safeAreaInsets

    var markerOffset: CGFloat {
        state != .tiny ? -(UIScreen.screens.first?.size.height ?? 0) * 0.25 : 0
    }

    var blur: Bool {
        viewModel.eventSheet != nil
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Group {
                    MapView(region: $viewModel.region, points: $viewModel.houses.withDefaultValue([]), markerCoord: $viewModel.markerLocation, markerOffset: markerOffset)
                    Image("marker").resizable().width(28).height(46).offset(0, markerOffset - (viewModel.markerUp ? 20 : 0))
                    VStack {
                        VStack(spacing: 0) {
                            Caption("Position")
                            Subtitle(viewModel.markerPosition).id(UUID()).transition(.opacity)
                        }.padding(.top, safeAreaInsets.top)
                        Spacer()
                    }
                    BottomSheetView(viewModel: .init(), state: $state.animation(), eventSheet: $viewModel.eventSheet)
                }.blurIf(blur, Constants.blur).allowsHitTesting(!blur)
                EventSheetView(viewModel: viewModel).id(viewModel.eventSheet?.id ?? nil)
            }
            .ignoresSafeArea()
            .navigationBarHidden(true)
        }.onChange(of: viewModel.houses) { _ in
            updateRegion()
        }.onChange(of: viewModel.region) { _ in
            withAnimation {
                viewModel.markerUp = true
            }
        }
    }
    
    private func updateRegion() {
        guard let housesCenter = viewModel.housesCenter else { return }
        withAnimation {
            viewModel.region.center = housesCenter
        }
    }
    
}
