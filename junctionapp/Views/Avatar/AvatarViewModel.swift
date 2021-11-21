//
//  AvatarViewModel.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 20.11.2021.
//

import Foundation
import SwiftUI

class AvatarViewModel: ViewModel {
    
    @Published var avatar: AvatarModel?// = .init(state: .fun2, message: "f sjfkl sjflk jsl fjsldjf lsj fk jlsj fljs fjslfj lsjf sjlf jslk jflsj ljs lfjl j jlj l ljsfj ljf lsjf lkjslfj slfjslfj")
    private let nw = NetworkService.shared

    @MainActor
    func task() async {
        do {
            let avatar = try await nw.fetchAvatar()
            withAnimation {
                self.avatar = avatar
            }
            if avatar.message != nil {
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [weak self] in
                    withAnimation {
                        self?.avatar?.message = nil
                    }
                }
            }
        } catch {
            //notifications.alert = "Avatar's data cannot be fetched"
        }
    }

    var timer: Timer?

    override func onAppear() {
        super.onAppear()
        timer?.invalidate()
        timer = .scheduledTimer(withTimeInterval: Constants.fetchInterval, repeats: true) { [weak self] _ in self?.checkAvatar() }
    }

    func onDisappear() {
        timer?.invalidate()
        timer = nil
    }

    func checkAvatar() {
        Task {
            await task()
        }
    }
}
