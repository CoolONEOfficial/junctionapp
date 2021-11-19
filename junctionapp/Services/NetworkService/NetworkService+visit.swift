//
//  NetworkService+visit.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 20.11.2021.
//

import Foundation
import Alamofire

extension NetworkService {
    struct VisitRequest: Encodable {
        let coord: CoordModel
        let date: TimeInterval
    }

    func visit(_ req: VisitRequest) async throws -> Bool {
        try await AF.request(
            apiBase + "/visit", method: .post, parameters: req.dict, encoding: JSONEncoding.default
        ).responseDecodable(of: Bool.self)
    }
}
