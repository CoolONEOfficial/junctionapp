//
//  ContentView.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 19.11.2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject var notifications = Notifications.shared

    @ViewBuilder
    var content: some View {
        MainView(viewModel: .init())
    }

    var body: some View {
        content.alert(isPresented: .init(get: {
            notifications.alert != nil
        }, set: {
            notifications.alert = $0 ? notifications.alert : nil
        })) {
            notifications.alert ?? .init(title: Text(""), message: nil, dismissButton: nil)
        }.overlay {
            ActivityIndicator(isLoading: notifications.isLoading)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
