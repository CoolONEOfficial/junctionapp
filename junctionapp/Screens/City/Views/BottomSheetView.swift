//
//  BottomSheetView.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 20.11.2021.
//

import Foundation
import SwiftUI
import SwiftUIX
import MapKit
import PureSwiftUI
import DynamicColor
import LightChart
import Snap
import SwiftDate

enum SectionType: String, CaseIterable {
    case water = "Water"
    case energy = "Energy"
    case exhaust = "Exhaust"
}

struct BottomSheetView: View {
    @StateObject var viewModel: CityViewModel
    @EnvironmentObject var theme: Theme
    @Binding var state: Snap.AppleMapsSnapState
    @State var isEditing = false
    @State var totalUnit: UnitModel?
    
    var totalUnitVal: UnitModel? {
        totalUnit ?? viewModel.buildings?.totals.first?.unit
    }
    
    @Binding var eventSheet: EventModel?
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    var bottomOffset: CGFloat {
        -safeAreaInsets.bottom - 25
    }
    
    var body: some View {
        SnapDrawer(state: .init(get: { state }, set: { state = isEditing ? state : $0 }), large: .paddingToTop(24), medium: .height(435), tiny: .height(90), allowInvisible: false, backgroundColor: .systemBackground) { state in
            VStack(alignment: .leading, spacing: 0) {
                Group {
                    SearchBar(text: $viewModel.query, onEditingChanged: isEditingDidChange, onCommit: onCommit).textFieldBackgroundColor(theme.secondary).placeholder("Search...")
                        .padding(.horizontal, 14).padding(.top, isEditing ? 120 : -10)
                    
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
    
    var mainScrollContent: some View {
        ScrollView {
            VStack(alignment: .leading) {
                LightChartView(data: [2, 17, 9, 23, 10],
                               type: .curved,
                               visualType: .filled(color: theme.textAccent, lineWidth: 3),
                               offset: 0.2,
                               currentValueLineType: .dash(color: .white, lineWidth: 2, dash: [2])
                ).aspectRatio(328/71, contentMode: .fit).padding(.vertical, 30).padding(.horizontal, -20)
                
                Title("Today")
                let event: EventModel = .init(name: "Name", sensorName: "Secson", value: 123, clusterName: "Cluster", count: 3, isEcoFriendly: false)
                ForEach(.init(0...30)) { num in
                    Button(action: {
                        withAnimation {
                            self.eventSheet = event
                        }
                    }, label: {
                        EventView(event: event)
                    })
                }
            }.padding(.horizontal, 20)
        }
    }
    
    var blocks: [BlockModel] {
        viewModel.buildings?.buildings.map(\.blocks).reduce([], +) ?? [ .mock, .mock, .mock ]
    }
    
    var sensors: [SensorModel] {
        let sensors = blocks.map(\.sensors).reduce([], +)
        return sensors.isNotEmpty ? sensors : [ .mock, .mock, .mock ]
    }

    var total: BuildingsResponse.Total? {
        viewModel.buildings?.totals.first(where: { $0.unit == self.totalUnitVal })
    }
    
    var buildingsLoading: Bool {
        viewModel.buildings == nil || viewModel.buildingsRefresh != nil
    }
    
    var secondPart: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading) {
                if state == .medium {
                    Group {
                        Subtitle("Spaces").padding(.vertical, 8)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(blocks.prefix(5)) { block in
                                    Button(action: {
                                        withAnimation {
                                            viewModel.selectedBlock = block
                                        }
                                    }) {
                                        PlainCard(block, isSelected: block == viewModel.selectedBlock, skelet: buildingsLoading).aspectRatio(134/50, contentMode: .fit).id(block.id)
                                    }
                                }
                            }.padding(.horizontal, 20)
                        }.height(70).padding(.horizontal, -20)
                        Subtitle("Devices").padding(.vertical, 8)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(sensors.prefix(5)) { sensor in
                                    Button(action: {
                                        withAnimation {
                                            viewModel.selectedSensor = sensor
                                        }
                                    }) {
                                        PlainCard(sensor, isSelected: sensor == viewModel.selectedSensor, skelet: buildingsLoading).aspectRatio(97/79, contentMode: .fit).id(sensor.id)
                                    }
                                }
                            }.padding(.horizontal, 20)
                        }.height(120).padding(.horizontal, -20)
                    }
                }
                
                DividerView().padding(.horizontal, -20)
                
                HStack(spacing: 0) {
                    Button(action: {
                        withAnimation {
                            viewModel.datePicker = true
                        }
                    }, label: {
                        Title(DateInRegion(viewModel.endDate).monthName(.default), color: theme.textAccent)
                    })
                    Title("expenses").padding(.horizontal, 6)
                    
                    Spacer()
                    
                    Button(action: nextUnit, label: {
                        Title("-\(String(format: "%.2f", total?.values ?? 0)) \(total?.unit.name ?? "")", weight: .regular).lineLimit(1).skelet(buildingsLoading).cornerRadius(Constants.cornerRadius).id(total?.unit.name ?? "").height(30)
                    }).disabled((viewModel.buildings?.totals.count ?? 0) <= 1)
                }.padding(.bottom, 8).padding(.top, -8)
                
            }.padding(.horizontal, 20)
        }
    }
    
    func nextUnit() {
        guard let units = viewModel.buildings?.totals.compactMap({ $0.unit }),
              let totalUnitVal = totalUnitVal,
              let currentIndex = units.firstIndex(of: totalUnitVal) else { return }
       
        withAnimation {
            totalUnit = currentIndex + 1 < units.count ? units[currentIndex + 1] : units[0]
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
//        Task {
//            await viewModel.update()
//        }
    }

}
