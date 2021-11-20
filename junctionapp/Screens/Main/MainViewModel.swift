//
//  MainViewModel.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 19.11.2021.
//

import Foundation
import SwiftUI

class MainViewModel: ViewModel {
    @Published var data: [MainModel]?

    private let nw = NetworkService.shared

    @MainActor
    func task() async {
        withAnimation {
            notifications.isLoading = true
        }
        defer {
            withAnimation {
                notifications.isLoading = false
            }
        }

        do {
            data = try await nw.fetchData()
        } catch {
            data = nil
        }
    }
}
