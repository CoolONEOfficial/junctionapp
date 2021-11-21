//
//  AvatarModel.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 20.11.2021.
//

import Foundation

struct AvatarModel: Codable {
    enum State: String, Codable {
        case poop = "STATE_1"
        case angry = "STATE_2"
        case sad = "STATE_3"
        case plain = "STATE_4"
        case fun1 = "STATE_5"
        case fun2 = "STATE_6"
        case fun3 = "STATE_7"
        
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
