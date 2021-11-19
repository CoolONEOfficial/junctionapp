//
//  Notifications.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 19.11.2021.
//

import Foundation
import SwiftUI
import SwiftUIX
import Alamofire

final class Notifications: ObservableObject {

    static let shared = Notifications()

    private init() {}

    @Published var alert: Alert? = nil
    @Published var isLoading = false
}
