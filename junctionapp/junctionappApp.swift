//
//  junctionappApp.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 19.11.2021.
//

import SwiftUI
import UIKit

@main
struct junctionappApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var theme = Theme()

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(theme)
        }
    }
}
