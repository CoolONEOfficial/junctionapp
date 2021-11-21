//
//  EventSheetView.swift
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

let handleVerticalPadding: CGFloat = 10
let handleThickness: CGFloat = 4

struct Handle : View {
    var body: some View {
        RoundedRectangle(cornerRadius: handleThickness / 2.0)
            .frame(width: 27, height: handleThickness)
            .foregroundColor(Color(.sRGB, red: 196/255, green: 196/255, blue: 196/255, opacity: 0.35))
            .padding(.vertical, handleVerticalPadding)
    }
}

struct EventSheetView: View {
    @StateObject var viewModel: CityViewModel
    @EnvironmentObject var theme: Theme
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    var gradientColor: DynamicColor {
        DynamicColor(Color.accentBad)
    }
    
    var body: some View {
        if let event = viewModel.eventSheet {
            SnapDrawer(state: .init(get: {.large}, set: { state in
                if state == .invisible {
                    withAnimation {
                        viewModel.eventSheet = nil
                    }
                }
                
            }), large: .height(335), allowInvisible: true, backgroundColor: .systemBackground) { state in
                VStack(alignment: .center, spacing: 0) {
                
                    RoundedRectangle(cornerRadius: Constants.cornerRadius)
                        .fill(LinearGradient([
                            Color(gradientColor.lighter(amount: 0.05)),
                            Color(gradientColor.darkened(amount: 0.05))
                        ], angle: Angle(degrees: 100)))
                        .height(128).maxWidth(.infinity).padding(.top, -25)
                        .overlay {
                            VStack(spacing: 0) {
                                Handle()
                                Text(event.dateTime.toFormat("d MMMM yyyy, HH:mm", locale: nil)).fontSize(13).foregroundColor(.white).padding(.top, 15)
                            }
                                .padding(.top, -75)
                        }
                        .overlay(alignment: .bottom) {
                            Color.white.height(100).clipCircleWithStroke(Color.red, lineWidth: 4, strokeType: .center, fill: Color.white).padding(.bottom, -50)
                                .overlay {
                                    Image(event.type.image).resizable().scaledToFit().width(65).height(65).padding(.bottom, -50)
                                }
                        }
                    
                
                    
                    Title("- \( String(format: "%.2f", event.value) )").fontSize(30).padding(.top, 70)
                    
                    Caption("\(event.name)").padding(.top, 10)
                    if let message = event.message {
                        Caption(message).padding(.top, 5)
                    }
                    //Rectangle().fill(Color.blue).height(200).width(200)
                    Spacer()
                }.background(Color(gradientColor).opacity(0.4)).padding(.bottom, -safeAreaInsets.bottom)
            }.transition(.move(edge: .bottom))
        }
    }
}

