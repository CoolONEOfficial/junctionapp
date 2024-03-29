//
//  PlainCard.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 20.11.2021.
//

import SwiftUI
import SwiftUIX
import LightChart
import PureSwiftUI

extension ChartWaterModel {
    var chartData: [PlainCard.ChartType: ChartModel] {
        [
            .waterCold: WATER_COLD,
            .waterHot: WATER_HOT,
            .energy: ENERGY
        ].compactMapValues { $0 }
    }
}

extension PlainCard {
    init(_ block: BlockModel, isSelected: Bool, skelet: Bool) {
        self.init(text: block.name, state: .good, isSelected: isSelected, type: nil, chartWater: block.charts, skelet: skelet)
    }
}

extension PlainCard {
    init(_ sensor: SensorModel, isSelected: Bool, skelet: Bool) {
        self.init(text: sensor.name, state: .good, isSelected: isSelected, type: nil, chartWater: sensor.charts, skelet: skelet)
    }
}

struct PlainCard: View {
    
    @EnvironmentObject var theme: Theme
    let text: String
    let state: State
    let isSelected: Bool
    
    let type: CardType?
    
    let chartWater: ChartWaterModel
    
    let skelet: Bool

    enum ChartType: Int {
        case waterCold
        case waterHot
        case energy
    
        var color: Color {
            switch self {
            case .waterHot:
                return .accentBad
            case .waterCold:
                return .accentGood
            case .energy:
                return .yellow
            }
        }
    }
    
    enum State {
        case good
        case bad
        //case selected
//
//        func color(_ theme: Theme) -> Color {
//            switch self {
//            case .bad: return .accentBad
//            case .good: return .accentGood
//            case .selected: return theme.accent
//            }
//        }
    }
    
    enum CardType {
        case washer
        
        var image: String {
            switch self {
            case .washer:
                return "washer"
            }
        }
    }
    
    @ViewBuilder
    var errIcon: some View {
        if state == .bad {
            Image("error").resizable().width(15).height(15)
        }
    }

    @ViewBuilder
    var chart: some View {
        ForecastWaterChart(data: chartWater)
        .maxHeight(.infinity).padding(.top, 33).opacity(type != nil ? 0.4 : 1)
    }
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 0) {
                if let type = type {
                    Image(type.image).resizable().width(70).height(70).padding(.bottom, 15).scale(0.9)
                }
                Text(text)
                    .semibold()
                    .foregroundColor(theme.text)
                    .fontSize(13)
                    .multilineTextAlignment(.leading)
                
                Spacer()
            }
            Spacer()
            errIcon
        }
        .padding(12)
        .background(chart.offset(0, 5), alignment: .bottom)
        .background(isSelected ? theme.accent : theme.secondary)
        .skelet(skelet)
        .cornerRadius(8)
        .clipped()
    }
}

//struct PlainCard_Previews: PreviewProvider {
//    static var previews: some View {
//        PlainCard(text: "Testtts", state: .bad, type: .washer).environmentObject(Theme()).width(97).height(79)
//    }
//}
