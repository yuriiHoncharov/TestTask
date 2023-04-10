//
//  ApiEndpoints.swift
//  TestTask
//
//  Created by Yurii Honcharov on 27.03.2023.
//

import Foundation

struct APIEndpoints {
    private static let environment = "https://api.themoviedb.org"
    private static func baseURL() -> String { return environment + "/3" }
    
    struct Movie {
        static func upcoming() -> String { return "\(baseURL())/movie/upcoming" }
        static func movieId() -> String { return "\(baseURL())/movie/%@" }
        static func topRated() -> String { return "\(baseURL())/movie/top_rated" }
    }
}
