//
//  BaseEntity.swift
//  WConnect
//
//  Created by Maksym Yevtukhivskiy on 25.01.2022.
//  Copyright © 2022 Lampa. All rights reserved.
//

import Foundation

protocol BaseResponseProtocol: Decodable {
    var error: String? { get set }
}

protocol TokenResponseProtocol {
    var token: String? { get set }
    var refreshToken: String? { get set }
    var expirationDate: String? { get set }
}
