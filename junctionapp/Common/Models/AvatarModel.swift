//
//  AvatarModel.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 20.11.2021.
//

import Foundation

struct AvatarModel: Codable {
    enum State: Int, Codable {
        case poop
        case angry
        case sad
        case plain
        case fun1
        case fun2
        case fun3
        
        var emoji: String {
            switch self {
            case .poop: return "💩"
            case .angry: return "😾"
            case .sad: return "😿"
            case .plain: return "😼"
            case .fun1: return "😹"
            case .fun2: return "😸"
            case .fun3: return "😺"
            }
        }
    }
    
    var state: State
    var message: String?
}
