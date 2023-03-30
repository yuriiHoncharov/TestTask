//
//  MovieInfoApiEntity.swift
//  TestTask
//
//  Created by Yurii Honcharov on 28.03.2023.
//

import Foundation

enum MovieInfoApiEntity {
    struct Request: Encodable {
        let apiKey: String
        let language: String
        let appendToResponse: String
        
        enum CodingKeys: String, CodingKey {
            case apiKey = "api_key"
            case language
            case appendToResponse = "append_to_response"
        }
    }
    
    struct MovieInfo: BaseResponseProtocol {
        var error: String?
        let adult: Bool
        let backdropPath: String
        // let belongsToCollection: JSONNull?
        let budget: Int
        let genres: [Genre]
        let homepage: String
        let id: Int
        let imdbID: String
        let originalLanguage: String
        let originalTitle, overview: String
        let popularity: Double
        let posterPath: String
        let productionCompanies: [ProductionCompany]
        let releaseDate: String
        let revenue, runtime: Int
        let status, tagline, title: String
        let video: Bool
        let voteAverage: Double
        let voteCount: Int
        
        enum CodingKeys: String, CodingKey {
            case adult
            case backdropPath = "backdrop_path"
            // case belongsToCollection = "belongs_to_collection"
            case budget, genres, homepage, id
            case imdbID = "imdb_id"
            case originalLanguage = "original_language"
            case originalTitle = "original_title"
            case overview, popularity
            case posterPath = "poster_path"
            case productionCompanies = "production_companies"
            case releaseDate = "release_date"
            case revenue, runtime
            case status, tagline, title, video
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
        }
    }
    
    // MARK: - Genre
    struct Genre: Codable {
        let id: Int
        let name: String
    }
    
    // MARK: - ProductionCompany
    struct ProductionCompany: Codable {
        let id: Int
        let logoPath: String?
        let name, originCountry: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case logoPath = "logo_path"
            case name
            case originCountry = "origin_country"
        }
    }
}
