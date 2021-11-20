//
//  DatePickerSheetView.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 21.11.2021.
//

import Foundation
import SwiftUI
import SwiftUIX
import MapKit
import PureSwiftUI
import DynamicColor
import LightChart
import SwiftDate
import Snap

struct DatePickerSheetView: View {
    @StateObject var viewModel: CityViewModel
    @EnvironmentObject var theme: Theme
    var datePicker: Bool
    @State var month: String = "December"
    @State var year: String = "2021"
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    var months: [String] = [
        "January",
        "February",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December"
    ]
    
    var years: [String] = (1990...2021).map { String($0) }
    
    var body: some View {
        if datePicker {
            SnapDrawer(state: .init(get: {.large}, set: { state in
                if state == .invisible {
                    withAnimation {
                        guard let monthNum = months.firstIndex(of: month), let date = DateInRegion("\(year)-\(monthNum)-01T00:00:00+0000") else { return }
                        withAnimation {
                            viewModel.startDate = date.date
                            viewModel.endDate = (date + 1.months).date
                            viewModel.datePicker = false
                        }
                    }
                }
            }), large: .height(200), allowInvisible: true, backgroundColor: .systemBackground) { state in
                GeometryReader { geometry in
                    HStack(spacing: 0) {
                        Picker("", selection: $month) {
                            ForEach(months, id: \.self) {
                                Text($0)
                            }
                        }.pickerStyle(.wheel)
                            .frame(maxWidth: geometry.size.width / 2)
                            .clipped()
                        Picker("", selection: $year) {
                            ForEach(years, id: \.self) {
                                Text($0)
                            }
                        }.pickerStyle(.wheel)
                            .frame(maxWidth: geometry.size.width / 2)
                            .clipped()
                    }.padding(.trailing, 20)
                }
            }.transition(.move(edge: .bottom))
                .onAppear(perform: {
                    month = months[viewModel.startDate.month]
                    year = String(viewModel.startDate.year)
                })
        }
    }
}

