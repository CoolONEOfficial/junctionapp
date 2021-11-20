//
//  NetworkService.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 19.11.2021.
//

import Alamofire
import Foundation

let dateFormatter: DateFormatter = {
    let df = DateFormatter()
    df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    return df
}()

actor NetworkService {
    static let shared = NetworkService()
    
    private init() {}
    
    let jsonDecoder: JSONDecoder = {
        let df = JSONDecoder()
        df.dateDecodingStrategy = .formatted(dateFormatter)
        return df
    }()
    
    let jsonEncoder: JSONEncoder = {
        let df = JSONEncoder()
        df.dateEncodingStrategy = .formatted(dateFormatter)
        return df
    }()
    
    let apiBase = "http://94.228.126.70:80/api"
}
