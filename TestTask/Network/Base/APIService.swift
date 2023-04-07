//
//  APIService.swift
//  WConnectUIKit
//
//  Created by Yurii Honcharov on 16.02.2023.
//

import Foundation

class APIService {
    let httpClient: HTTPClientProvider
    let jsonParser: JSONParserServiceProtocol
    
    private lazy var secureStorage = SecureStorage()
    
    init() {
        self.httpClient = HTTPClient.shared
        self.jsonParser = HTTPClient.shared.jsonParser
    }
    
    func handleResponseResult<T: BaseResponseProtocol>(result: Result<Data, Error>,
                                                       responseModel: T.Type,
                                                       completion: @escaping (Result<T, Error>) -> Void) {
        switch result {
        case .success(let data):
            print(String(decoding: data, as: UTF8.self))
            
            self.jsonParser.parseJSON(of: responseModel.self, from: data) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let response):
                    if let errorMessage = response.error {
                        completion(.failure(errorMessage as! Error))
                        break
                    }
                    
                    if let response = response as? TokenResponseProtocol {
                        let accessData = AccessDataEntity(token: response.token ?? "",
                                                          refreshToken: response.refreshToken ?? "",
                                                          expirationDate: response.expirationDate ?? "")
                        self.secureStorage.save(with: SecureStorageKeys.kAccessData, value: accessData)
                    }
                    
                    completion(.success(response))
                    
                case .failure(let error):
                    let errorMessage = error.localizedDescription
                    print(errorMessage)
                    completion(.failure(error as NSError))
                }
            }
            
        case .failure(let error):
            print(error)
            completion(.failure(error))
        }
    }
    
    func handleResponseResult(result: Result<Data, Error>,
                              completion: @escaping (Result<Bool, Error>) -> Void) {
        DispatchQueue.main.async {
            switch result {
            case .success(let data):
                print(String(decoding: data, as: UTF8.self))
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func handleResponseResult<T: BaseResponseProtocol>(result: Result<Data, Error>,
                                                       responseModels: [T].Type,
                                                       completion: @escaping (Result<[T], Error>) -> Void) {
        DispatchQueue.main.async {
            switch result {
            case .success(let data):
                print(String(decoding: data, as: UTF8.self))
                
                self.jsonParser.parseJSON(of: responseModels.self, from: data) { result in
                    switch result {
                    case .success(let response):
                        completion(.success(response))
                        
                    case .failure(let error):
                        print(error)
                        let errorMessage = error.localizedDescription
                        completion(.failure(errorMessage as! Error))
                    }
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
