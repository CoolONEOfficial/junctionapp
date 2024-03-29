//
//  ContentView.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 19.11.2021.
//

import SwiftUI
import UserNotifications
import MapKit

struct ContentView: View {
    @StateObject var notifications = Notifications.shared

    @ViewBuilder
    var content: some View {
        CityView(viewModel: .init())
    }

    var body: some View {
        content.alert(isPresented: .init(get: {
            notifications.alert != nil
        }, set: {
            notifications.alert = $0 ? notifications.alert : nil
        })) {
            notifications.alert ?? .init(title: Text(""), message: nil, dismissButton: nil)
        }.blurIf(notifications.isLoading, Constants.blur).overlay {
            ActivityIndicator(isLoading: notifications.isLoading)
        }
        .modifier(NotificationsViewModifier(viewModel: .init()))
        .modifier(AvatarViewModifier(viewModel: .init()))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
