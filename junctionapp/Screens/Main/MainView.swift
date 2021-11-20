//
//  MainView.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 19.11.2021.
//

import SwiftUI
import SwiftUIX
import MapKit

struct MainView: View {
    @EnvironmentObject var theme: Theme
    @StateObject var viewModel: MainViewModel

    @State var region: MKCoordinateRegion = MKCoordinateRegion(
        center: .init(latitude: 40.7128, longitude: 74.0060),
        
        span: MKCoordinateSpan(
            latitudeDelta: 10,
            longitudeDelta: 10
        )
    )

    var body: some View {
        NavigationView {
            VStack {
                if let data = viewModel.data {
                    ScrollView {
                        VStack {
                            ForEach(enumerating: data, id: \.id) { _, entry in
                                Text(entry.name ?? String(entry.id)).padding()
                            }
                        }
                    }
                }
            }
        }
        .task {
            await viewModel.task()
        }
    }
        
}
