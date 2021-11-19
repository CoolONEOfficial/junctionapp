//
//  ViewModel.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 19.11.2021.
//

import Foundation
import SwiftUI
import SwiftUIX
import Alamofire

class ViewModel: ObservableObject {
    var notifications: Notifications = .shared

    func checkNetwork() {
        guard Alamofire.NetworkReachabilityManager.default?.isReachable == true else {
            self.notifications.alert = "Нет интернета!"
            return
        }
    }

    func onAppear() {
        notifications.isLoading = false
        notifications.alert = nil
    }
}
