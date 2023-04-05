//
//  UpcomingApiEntity.swift
//  TestTask
//
//  Created by Yurii Honcharov on 27.03.2023.
//

import Foundation

enum UpcomingApiEntity {
    struct Request: Encodable {
        let apiKey: String = Constants.apiKey
        let language: String = Language.english.rawValue
        let page: Int
        
        enum CodingKeys: String, CodingKey {
            case apiKey = "api_key"
            case language, page
        }
    }
    struct UpcomingMovies: BaseResponseProtocol {
        var error: String?
        let dates: Dates?
        let page: Int?
        let results: [Item]?
        let totalPages, totalResults: Int?
        
        enum CodingKeys: String, CodingKey {
            case dates, page, results
            case totalPages = "total_pages"
            case totalResults = "total_results"
        }
    }
    
    struct Dates: Decodable {
        let maximum, minimum: String
    }
    
    struct Item: Decodable {
        let adult: Bool
        let backdropPath: String?
        let genreIDS: [Int]
        let id: Int
        let originalLanguage, originalTitle, overview: String
        let popularity: Double
        let posterPath: String?
        let releaseDate, title: String
        let video: Bool
        let voteAverage: Double
        let voteCount: Int
        
        enum CodingKeys: String, CodingKey {
            case adult
            case backdropPath = "backdrop_path"
            case genreIDS = "genre_ids"
            case id
            case originalLanguage = "original_language"
            case originalTitle = "original_title"
            case overview, popularity
            case posterPath = "poster_path"
            case releaseDate = "release_date"
            case title, video
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
        }
    }
}
