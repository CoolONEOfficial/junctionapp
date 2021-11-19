//
//  NetworkService+notification.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 20.11.2021.
//

import Foundation
import Alamofire

extension NetworkService {
    func fetchNotification() async throws -> NotificationModel {
        try await AF.request(apiBase + "/notifications").responseDecodable(of: NotificationModel.self)
    }
}
