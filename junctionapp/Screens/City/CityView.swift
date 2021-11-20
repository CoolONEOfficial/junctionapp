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

    var body: some View {
        NavigationView {
            ZStack {
                MapView(region: $viewModel.region, points: $viewModel.houses.withDefaultValue([]), markerCoord: $viewModel.markerLocation, markerOffset: markerOffset)
                Image("marker").resizable().width(28).height(46).offset(0, markerOffset - (viewModel.markerUp ? 20 : 0))
                VStack {
                    VStack(spacing: 0) {
                        Caption("Position")
                        Subtitle(viewModel.markerPosition).id(UUID()).transition(.opacity)
                    }.padding(.top, safeAreaInsets.top)
                    Spacer()
                }
                BottomSheetView(viewModel: .init(), state: $state.animation())
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

private struct BottomSheetView: View {
    @StateObject var viewModel: CityViewModel
    @EnvironmentObject var theme: Theme
    @Binding var state: Snap.AppleMapsSnapState
    @State var isEditing = false
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    var bottomOffset: CGFloat {
        -safeAreaInsets.bottom - 25
    }
    
    var body: some View {
        SnapDrawer(state: .init(get: { state }, set: { state = isEditing ? state : $0 }), large: .paddingToTop(24), medium: .height(435), tiny: .height(90), allowInvisible: false, backgroundColor: .systemBackground) { state in
            VStack(alignment: .leading, spacing: 0) {
                Group {
                    SearchBar(text: $viewModel.query, onEditingChanged: isEditingDidChange, onCommit: onCommit).textFieldBackgroundColor(theme.secondary).placeholder("Search...")
                        .padding(.horizontal, 14).padding(.top, isEditing ? 110 : -10)
                    
                    SectionsView(sections: SectionType.allCases.map(\.rawValue), selectedIndexes: $viewModel.selectedSections).padding(.horizontal, -8)
                        .padding(.bottom, state == .large ? -8 : 0)
                }
                
                
                if state != .tiny {
                    secondPart
                        .transition(.opacity)
                        .padding(.bottom, bottomOffset)
                }
                
                if state == .large {
                    mainScrollContent
                        .padding(.top, -bottomOffset)
                        .transition(.opacity.combined(with: .move(edge: .bottom)))
                        .padding(.bottom, bottomOffset)
                }
                
                Spacer()
            }
        }
    }
    
    enum SectionType: String, CaseIterable {
        case water = "Water"
        case energy = "Energy"
    }
    
    var mainScrollContent: some View {
        ScrollView {
            VStack(alignment: .leading) {
                LightChartView(data: [2, 17, 9, 23, 10],
                               type: .curved,
                               visualType: .filled(color: theme.textAccent, lineWidth: 3),
                               offset: 0.2,
                               currentValueLineType: .dash(color: .white, lineWidth: 1, dash: [1])
                ).aspectRatio(328/71, contentMode: .fit).padding(.vertical, 30).padding(.horizontal, -20)
                
                Title("Today")
                ForEach(.init(0...30)) { num in
                    EventView(event: .init(name: "Name", sensorName: "Secson", value: 123, clusterName: "Cluster", count: 3, isEcoFriendly: false))
                }
            }.padding(.horizontal, 20)
        }
    }

    var divider: some View {
        InvertedMask(color: theme.secondary).padding(.horizontal, -20).padding(.vertical, -Constants.cornerRadius)
        
    }
    
    var secondPart: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading) {
                if state == .medium {
                    Group {
                        Subtitle("Blocks").padding(.vertical, 8)
                        ScrollView(.horizontal) {
                            LazyHStack {
                                PlainCard(text: "Test", state: .bad, type: nil).aspectRatio(134/50, contentMode: .fit)
                            }
                        }.height(70)
                        Subtitle("Entities").padding(.vertical, 8)
                        ScrollView(.horizontal) {
                            LazyHStack {
                                PlainCard(text: "Test", state: .bad, type: .washer).aspectRatio(97/79, contentMode: .fit)
                            }
                        }.height(120)
                    }
                }
                
                divider
                
                HStack(spacing: 6) {
                    Title("Spending in")
                    Button(action: {
                        
                    }, label: {
                        Title("november", color: theme.textAccent)
                    })
                    
                    Spacer()
                    Title("-65523 ml", weight: .regular)
                }.padding(.bottom, 8).padding(.top, -8)
                
                
            }.padding(.horizontal, 20)
        }
    }
    
    func isEditingDidChange(isEditing: Bool) {
        self.isEditing = isEditing
        if isEditing {
            withAnimation {
                state = .large
            }
        }
    }
    
    func onCommit() {
        Task {
            await viewModel.update()
        }
    }
}

func HoleShapeMask(in rect: CGRect) -> Path {
    let cornerRadius = Constants.cornerRadius * 2
    var shape = Rectangle().path(in: rect)
    shape.addPath(PartRoundedRectangle(corners: [.bottomRight, .bottomLeft], cornerRadii: cornerRadius).path(in: .init(0, 0, rect.width, cornerRadius)))
    shape.addPath(PartRoundedRectangle(corners: [.topLeft, .topRight], cornerRadii: cornerRadius).path(in: .init(0, rect.height - cornerRadius, rect.width, cornerRadius)))
    return shape
}

struct InvertedMask: View {
    let color: Color
    var body: some View {
        GeometryReader {
            Rectangle()
                .fill(color)
                .mask(HoleShapeMask(in: .init($0.size)).fill(style: FillStyle(eoFill: true)))
        }.height(Constants.cornerRadius * 4 + 8)
            .allowsHitTesting(false)
    }
}
