//
//  junctionappApp.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 19.11.2021.
//

import SwiftUI

@main
struct junctionappApp: App {
    @StateObject var theme = Theme()

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(theme)
        }
    }
}
