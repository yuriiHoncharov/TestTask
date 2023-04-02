//
//  UpcomingAPI.swift
//  TestTask
//
//  Created by Yurii Honcharov on 27.03.2023.
//

import Foundation

class MovieRequest: APIService {
    func getAllUpcomingMovies(params: UpcomingApiEntity.Request, completion: @escaping (Result<UpcomingApiEntity.UpcomingMovies, Error>) -> Void) {
        let url = APIEndpoints.Movie.upcoming()
        httpClient.request(method: .get, url: url, withToken: false, images: nil, params: params) { [weak self] response in
            guard let self = self else { return }
            self.handleResponseResult(result: response, responseModel: UpcomingApiEntity.UpcomingMovies.self, completion: completion)
        }
    }
    
    func getMovieById(id: Int, params: MovieInfoApiEntity.Request, completion: @escaping (Result<MovieInfoApiEntity.MovieInfo, Error>) -> Void) {
        let url = String(format: APIEndpoints.Movie.movieId(), String(id))
        
        httpClient.request(method: .get, url: url, withToken: false, images: [], params: params) { [weak self] response in
            guard let self else { return }
            self.handleResponseResult(result: response, responseModel: MovieInfoApiEntity.MovieInfo.self, completion: completion)
        }
    }
}
