//
//  DividerView.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 20.11.2021.
//

import Foundation
import SwiftUI
import SwiftUIX

struct DividerView: View {

    @EnvironmentObject var theme: Theme
    
    var body: some View {
        GeometryReader {
            Rectangle()
                .fill(theme.secondary)
                .mask(HoleShapeMask(in: .init($0.size)).fill(style: FillStyle(eoFill: true)))
        }.height(Constants.cornerRadius * 4 + 8)
            .allowsHitTesting(false)
            .padding(.vertical, -Constants.cornerRadius)
    }
    
    func HoleShapeMask(in rect: CGRect) -> Path {
        let cornerRadius = Constants.cornerRadius * 2
        var shape = Rectangle().path(in: rect)
        shape.addPath(PartRoundedRectangle(corners: [.bottomRight, .bottomLeft], cornerRadii: cornerRadius).path(in: .init(0, 0, rect.width, cornerRadius)))
        shape.addPath(PartRoundedRectangle(corners: [.topLeft, .topRight], cornerRadii: cornerRadius).path(in: .init(0, rect.height - cornerRadius, rect.width, cornerRadius)))
        return shape
    }
}
