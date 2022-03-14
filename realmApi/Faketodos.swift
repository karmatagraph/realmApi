//
//  Faketodos.swift
//  realmApi
//
//  Created by karma on 3/14/22.
//

import Foundation
struct Faketodos: Codable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
    
    enum CodingKeys: CodingKey {
        case userId, id, title, completed
    }
    
}
