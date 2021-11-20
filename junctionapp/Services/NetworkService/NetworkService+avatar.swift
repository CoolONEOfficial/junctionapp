//
//  NetworkService+avatar.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 20.11.2021.
//

import Foundation
import Alamofire

extension NetworkService {
    func fetchAvatar() async throws -> AvatarModel {
        try await AF.request(apiBase + "/avatar").responseDecodable(of: AvatarModel.self)
    }
}
