//
//  MovieInfoMapper.swift
//  TestTask
//
//  Created by Yurii Honcharov on 07.04.2023.
//

import Foundation

struct MovieInfoEntity: Identifiable {
    let id: Int
    let backdropPath: String
    let overview: String
    let popularity: Double
    let posterPath: String
    let releaseDate: String
    let title: String
    let video: Bool
}

struct MovieInfoEntityMapper {
    static func map(_ entity: MovieInfoApiEntity.MovieInfo, dateUtility: DateFormatterUtility) -> MovieInfoEntity {
        let correctDate = dateUtility.refactoringDate(from: entity.releaseDate)
        return MovieInfoEntity(id: entity.id,
                               backdropPath: entity.backdropPath,
                               overview: entity.overview,
                               popularity: entity.voteAverage,
                               posterPath: entity.posterPath,
                               releaseDate: correctDate,
                               title: entity.title,
                               video: entity.video)
    }
}
