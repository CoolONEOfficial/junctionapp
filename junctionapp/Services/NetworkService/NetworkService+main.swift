//
//  NetworkService+main.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 19.11.2021.
//

import Foundation
import Alamofire

extension NetworkService {
    func fetchData() async throws -> [MainModel] {
        try await AF.request(apiBase + "/users").responseDecodable(of: [MainModel].self)
    }
}
