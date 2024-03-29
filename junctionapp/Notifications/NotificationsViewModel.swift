//
//  NotificationsViewModel.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 20.11.2021.
//

import Foundation
import UserNotifications

class NotificationsViewModel: ObservableObject {
    let nw = NetworkService.shared

    var timer: Timer?

    func onAppear() {
        timer?.invalidate()
        timer = .scheduledTimer(withTimeInterval: Constants.fetchInterval, repeats: true) { [weak self] _ in self?.checkNotifications() }
    }

    func onDisappear() {
        timer?.invalidate()
        timer = nil
    }

    @MainActor
    func task() async {
        guard let notification = try? await nw.fetchNotification(),
              let title = notification.title else { return }
        let content = UNMutableNotificationContent()
        content.title = title
        if let msg = notification.message {
            content.body = msg
        }
        content.sound = .default
        //content.userInfo = notification.data TODO: notification userInfo
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        try! await UNUserNotificationCenter.current().add(request)
    }

    func checkNotifications() {
        Task {
            await task()
        }
    }
}
