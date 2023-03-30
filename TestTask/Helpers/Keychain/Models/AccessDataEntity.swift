//
//  AccessDataEntity.swift
//  WConnect
//
//  Created by Maksym Yevtukhivskiy on 13.04.2022.
//  Copyright © 2022 Lampa. All rights reserved.
//

import Foundation

struct AccessDataEntity: Codable {
    let token: String
    let refreshToken: String
    let expirationDate: TimeInterval
    
    init(token: String, refreshToken: String, expirationDate: String) {
        self.token = token
        self.refreshToken = refreshToken
        
        if let expiredAt = TimeInterval(expirationDate) {
            let date = Date().addingTimeInterval(expiredAt).timeIntervalSince1970
            self.expirationDate = date
        } else {
            self.expirationDate = 0
        }
    }
}
