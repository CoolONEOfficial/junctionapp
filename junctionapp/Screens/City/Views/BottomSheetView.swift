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

struct BottomSheetView: View {
    @StateObject var viewModel: CityViewModel
    @EnvironmentObject var theme: Theme
    @Binding var state: Snap.AppleMapsSnapState
    @State var isEditing = false
    
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
                
                DividerView().padding(.horizontal, -20)
                
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
