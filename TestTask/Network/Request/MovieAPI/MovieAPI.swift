//
//  UpcomingAPI.swift
//  TestTask
//
//  Created by Yurii Honcharov on 27.03.2023.
//

import Foundation

class MovieRequest: APIService {
    func getAllUpcomingMovies(params: UpcomingApiEntity.Request) async throws -> UpcomingApiEntity.UpcomingMovies {
        let url = APIEndpoints.Movie.upcoming()
        let data = try await httpClient.request(method: .get, url: url, withToken: false, images: nil, params: params)

        guard let upcomingMovies = try? JSONDecoder().decode(UpcomingApiEntity.UpcomingMovies.self, from: data) else {
            throw NSError()
        }
        return upcomingMovies
    }

    func getAllTopMovies(params: TopRateApiEntity.Request) async throws -> TopRateApiEntity.MovieRate {
        let url = APIEndpoints.Movie.topRated()
        let data = try await httpClient.request(method: .get, url: url, withToken: false, images: nil, params: params)

        guard let upcomingMovies = try? JSONDecoder().decode(TopRateApiEntity.MovieRate.self, from: data) else {
            throw NSError()
        }
        return upcomingMovies
    }

    func getMovieById(id: Int, params: MovieInfoApiEntity.Request) async throws -> MovieInfoApiEntity.MovieInfo {
        let url = String(format: APIEndpoints.Movie.movieId(), String(id))

        let data = try await httpClient.request(method: .get, url: url, withToken: false, images: [], params: params)

        guard let upcomingMovies = try? JSONDecoder().decode(MovieInfoApiEntity.MovieInfo.self, from: data) else {
            throw NSError()
        }
        return upcomingMovies
    }
}
