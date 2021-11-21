//
//  AppDelegate.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 20.11.2021.
//

import Foundation
import UIKit
import UserNotifications
import SwiftLocation

public let NOTIFICATION_VISITS_DATA = Notification.Name("NOTIFICATION_VISITS_DATA")

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("Your code here")
        
        SwiftLocation.onRestoreVisits = AppDelegate.onRestoreVisitsRequests

        SwiftLocation.restoreState()

        let activeRequest = SwiftLocation.visits(activityType: .other)
        AppDelegate.attachSubscribersToVisitsRegions([activeRequest])
        
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        if response.actionIdentifier == "markAsDone" {
            //let userInfo = response.notification.request.content.userInfo
            // TODO: handle notification
        }
        completionHandler()
    }
    
    public static func attachSubscribersToVisitsRegions(_ requests: [VisitsRequest?]) {
        for request in requests {
            if let unwrappedRequest = request {
                unwrappedRequest.then(queue: .main) { result in
                    NotificationCenter.default.post(name: NOTIFICATION_VISITS_DATA, object: result, userInfo: nil)
                    
                    switch result {
                    case .success(let visit):
                        Task {
                            try? await NetworkService.shared.visit(.init(coord: .init(visit.coordinate), date: visit.arrivalDate.timeIntervalSince1970))
                        }
                        
                    case .failure(let error):
                        fatalError(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    public static func onRestoreVisitsRequests(_ requests: [VisitsRequest]) {
        guard requests.isEmpty == false else {
            return
        }
        
        print("Restoring \(requests.count) visits requests...")
        attachSubscribersToVisitsRegions(requests)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification,
                                    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            // Forground notifications.
            completionHandler([.alert, .sound])
        }
    
    
}
