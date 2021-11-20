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

struct PlainCard: View {
    
    @EnvironmentObject var theme: Theme
    let text: String
    let state: State
    
    enum State {
        case good
        case bad

        var color: Color {
            switch self {
            case .bad: return .accentBad
            case .good: return .accentGood
            }
        }
    }
    
    let type: CardType?
    
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
    
    var demoData: [Double] = [8, 2, 4, 6, 12, 9, 2]
    
    @ViewBuilder
    var chart: some View {
        LightChartView(data: [2, 17, 9, 23, 10],
                       type: .curved,
                       visualType: .filled(color: state.color, lineWidth: 3),
                       offset: 0.2
                       //currentValueLineType: .dash(color: .gray, lineWidth: 1, dash: [5])
        ).maxHeight(.infinity).padding(.top, 33).opacity(type != nil ? 0.4 : 1)
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
                
                Spacer()
            }
            Spacer()
            errIcon
        }
        .padding(12)
        .background(chart.offset(0, 5), alignment: .bottom)
        .background(theme.secondary)
        .cornerRadius(8)
        .clipped()
    }
}

struct PlainCard_Previews: PreviewProvider {
    static var previews: some View {
        PlainCard(text: "Testtts", state: .bad, type: .washer).environmentObject(Theme()).width(97).height(79)
    }
}
