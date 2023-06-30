//
//  NetworkManager.swift
//  Pokedex
//
//  Created by Mustafa Ali Dikcinar on 28.06.2023.
//

import Alamofire
import Foundation

final class NetworkManager {
    static let instance = NetworkManager()

    private init() {}

    private let headers: HTTPHeaders = ["Content-Type": "application/json"]

    public func graphQL<T: Decodable>(requestQuery: String, model: T.Type, completion: @escaping (AFResult<Decodable>) -> Void) {
        AF.request(
            APIConstants.GraphQLURL,
            method: HTTPMethod.post,
            parameters: ["query": requestQuery],
            encoding: JSONEncoding.default,
            headers: headers
        )
        .validate()
        .responseDecodable(of: ResponseData<T>.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
