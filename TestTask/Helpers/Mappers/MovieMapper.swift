//
//  MovieMapper.swift
//  TestTask
//
//  Created by Yurii Honcharov on 05.04.2023.
//

import Foundation

struct MovieEntity: Identifiable {
    let id: Int
    let backdropPath: String?
    let overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate: String
    let title: String
}

struct MovieEntityMapper {
    static func mapUpcoming(_ entity: UpcomingApiEntity.Item, dateUtility: DateFormatterUtility) -> MovieEntity {
        let correctDate = dateUtility.refactoringDate(from: entity.releaseDate)
        return MovieEntity(id: entity.id,
                           backdropPath: entity.backdropPath,
                           overview: entity.overview,
                           popularity: entity.popularity,
                           posterPath: entity.posterPath,
                           releaseDate: correctDate,
                           title: entity.title)
    }
    
    static func mapTop(_ entity: TopRateApiEntity.Item, dateUtility: DateFormatterUtility) -> MovieEntity {
        let correctDate = dateUtility.refactoringDate(from: entity.releaseDate)
        return MovieEntity(id: entity.id,
                           backdropPath: entity.backdropPath,
                           overview: entity.overview,
                           popularity: entity.popularity,
                           posterPath: entity.posterPath,
                           releaseDate: correctDate,
                           title: entity.title)
    }
}
