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
            Ellipse().fill(event.isEcoFriendly ? Color.eco : Color.notEco).width(55).height(55).overlay(alignment: .bottomTrailing) {
                if event.count > 1 {
                    Ellipse().fill(event.isEcoFriendly ? Color.eco : Color.notEco).width(22).height(22)
                        .strokeCircle(Color.white, lineWidth: 1).overlay {
                        Text("x\(event.count)").fontSize(10)
                    }
                }
            }
            VStack {
                Subtitle(event.name)
                Caption(event.sensorName)
            }
            Spacer()
            VStack {
                Subtitle(event.name, weight: .regular)
                Caption(event.clusterName)
            }
        }
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView(event: .init(name: "Name", sensorName: "Secson", value: 123, clusterName: "Cluster", count: 3, isEcoFriendly: false))
    }
}
