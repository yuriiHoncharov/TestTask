//
//  JSONParserServiceProtocol.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 16.02.2023.
//

import Foundation

protocol JSONParserServiceProtocol {
    func parseJSON<T: Decodable>(of type: T.Type, from data: Data, completion: @escaping (Result<T, Error>) -> Void)
}

class JSONParserService: JSONParserServiceProtocol {
    func parseJSON<T>(of type: T.Type, from data: Data, completion: @escaping (Result<T, Error>) -> Void) where T: Decodable {
        do {
            let response: T = try JSONDecoder().decode(T.self, from: data)
            completion(.success(response))
        } catch let error {
            completion(.failure(error))
        }
    }
}
