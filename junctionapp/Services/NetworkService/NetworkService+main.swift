//
//  NetworkService+main.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 19.11.2021.
//

import Foundation
import Alamofire

extension NetworkService {
    struct MainRequest: Encodable {
        let test: String
    }

    func fetchData(_ req: MainRequest) async throws -> [MainModel] {
        try await AF.request(apiBase + "/users"//, method: .post, parameters: req.dict, encoding: JSONEncoding.default
        ).responseDecodable(of: [MainModel].self)
    }
}
