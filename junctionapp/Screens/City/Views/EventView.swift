//
//  EventView.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 20.11.2021.
//

import SwiftUI

struct EventView: View {
    let event: EventModel

    var body: some View {
        HStack(spacing: 12) {
            let isEcoFriendly = event.isEco == true || event.isAnomaly == false
            Ellipse().fill(isEcoFriendly ? Color.eco : Color.notEco).width(55).height(55).overlay {
                Image(event.type.image).resizable().scaledToFit().width(35).height(35)
            }.overlay(alignment: .bottomTrailing) {
                if let count = event.count, count > 1 {
                    Ellipse().fill(isEcoFriendly ? Color.eco : Color.notEco).width(22).height(22)
                        .strokeCircle(Color.white, lineWidth: 1).overlay {
                        Text("x\(count)").fontSize(10)
                    }
                }
            }
            VStack(spacing: 0) {
                HStack(alignment: .top, spacing: 0) {
                    Subtitle(event.name)
                    Spacer()
                    Caption(event.sensorName).multilineTextAlignment(.trailing)
                }
                Spacer()
                HStack(alignment: .bottom, spacing: 0) {
                    Subtitle(event.name, weight: .regular)
                    Spacer()
                    Caption(event.blockName).multilineTextAlignment(.trailing)
                }
            }.padding(.vertical, 14)
            
        }
    }
}

//struct EventView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventView(event: .init(name: "Name", sensorName: "Secson", value: 123, clusterName: "Cluster", count: 3, isEcoFriendly: false))
//    }
//}
