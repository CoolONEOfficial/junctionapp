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
import SkeletonUI

struct CityView: View {
    @EnvironmentObject var theme: Theme
    @StateObject var viewModel: CityViewModel
    
    @State var state: Snap.AppleMapsSnapState = .medium
    @Environment(\.safeAreaInsets) private var safeAreaInsets

    var markerOffset: CGFloat {
        state != .tiny ? -(UIScreen.screens.first?.size.height ?? 0) * 0.25 : 0
    }

    var blur: Bool {
        viewModel.eventSheet != nil || viewModel.datePicker
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
                            Subtitle(viewModel.markerPosition).id(UUID()).transition(.opacity).padding(.horizontal, 40)
                        }.padding(.top, safeAreaInsets.top)
                        Spacer()
                    }.opacity(state == .large ? 0 : 1)
                    BottomSheetView(viewModel: viewModel, state: $state.animation(), eventSheet: $viewModel.eventSheet)
                }.blurIf(blur, Constants.blur).allowsHitTesting(!blur)
                EventSheetView(viewModel: viewModel).id(viewModel.eventSheet?.id ?? nil)
                DatePickerSheetView(viewModel: viewModel, datePicker: viewModel.datePicker)
            }
            .ignoresSafeArea()
            .navigationBarHidden(true)
        }.onChange(of: viewModel.houses) { _ in
            //updateRegion()
        }.onChange(of: viewModel.region) { _ in
            withAnimation {
                viewModel.markerUp = true
            }
        }.task {
            await viewModel.fetchBuildings()
        }
    }
//
//    private func updateRegion() {
//        guard let housesCenter = viewModel.housesCenter else { return }
//        withAnimation {
//            viewModel.region.center = housesCenter
//        }
//    }
    
}
