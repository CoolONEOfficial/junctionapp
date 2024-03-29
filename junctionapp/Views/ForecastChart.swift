//
//  ForecastChart.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 21.11.2021.
//

import SwiftUI
import LightChart
import PureSwiftUI

struct ForecastWaterChart: View {
    var data: ChartWaterModel
    
    var body: some View {
        ZStack {
            ForEach(Array(data.chartData.enumerated()), id: \.offset) { type, entry in
                let value = entry.value
                if value.data.isNotEmpty {
                    ForecastChart(data: value, color: entry.key.color)
                }
            }
        }
    }
}

struct ForecastChart: View {
    var data: ChartModel
    var color: Color

    var forecast: Double {
        guard let futureIndex = data.data.firstIndex(where: { $0.date.isInFuture }) else { return 1 }
        return (Double(futureIndex) + 1) / Double(data.data.count)
    }
    
    var gradientColor: Color {
        color.opacity(0.6)
    }
    
    var forecastColor: Color {
        color.opacity(0.15)
    }
    
    var gradient: LinearGradient {
        .linearGradient(stops: [ Gradient.Stop(color: gradientColor, location: 0), Gradient.Stop(color: gradientColor, location: forecast), Gradient.Stop(color: forecastColor, location: min(forecast + 0.1, 1)), .init(color: forecastColor, location: 1) ], startPoint: .leading, endPoint: .trailing)
    }
    
    var body: some View {
        LightChartView(data: data.data.map(\.value),
                       type: .curved,
                       visualType: .filled(color: color, lineWidth: 3),
                       offset: 0.2,
                       currentValueLineType: .dash(color: .white, lineWidth: 2, dash: [2])
        ).mask(
            gradient
        )
    }
}

//struct ForecastChart_Previews: PreviewProvider {
//    static var previews: some View {
//        ForecastChart()
//    }
//}
