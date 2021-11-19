//
//  MainViewModel.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 19.11.2021.
//

import Foundation

class MainViewModel: ViewModel {
    @Published var data: [MainModel]?

    private let nw = NetworkService.shared

    @MainActor
    func task() async {
        notifications.isLoading = true
        defer { notifications.isLoading = false }

        do {
            data = try await nw.fetchData(.init(test: "test"))
        } catch {
            data = nil
        }
    }
}
