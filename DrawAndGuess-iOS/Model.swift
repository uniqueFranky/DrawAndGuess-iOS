//
//  Model.swift
//  DrawAndGuess-iOS
//
//  Created by 闫润邦 on 2022/7/13.
//

import Foundation

class User: Codable {
    var userName: String
    var userId: String
    
    init() {
        userName = ""
        userId = ""
    }
}
