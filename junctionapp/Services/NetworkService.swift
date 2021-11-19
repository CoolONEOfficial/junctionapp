//
//  NetworkService.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 19.11.2021.
//

import Alamofire
import Foundation

actor NetworkService {
    static let shared = NetworkService()
    
    private init() {}
    
    let apiBase = "http://94.228.126.70:80/api"
}
