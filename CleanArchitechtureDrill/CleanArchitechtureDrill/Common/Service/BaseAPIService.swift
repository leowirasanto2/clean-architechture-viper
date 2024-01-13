//
//  BaseAPIService.swift
//  CleanArchitechtureDrill
//
//  Created by Leo Laia on 31/12/23.
//

import Foundation
import CoreData

struct APIRequest {
    var endPoint: String
    var parameters: [String: String]?
    var keyCodingStrategy: JSONDecoder.KeyDecodingStrategy
    
    init(endPoint: String, parameters: [String : String]? = nil, keyCodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase) {
        self.endPoint = endPoint
        self.parameters = parameters
        self.keyCodingStrategy = keyCodingStrategy
    }
}

protocol APIService: AnyObject {
    func fetch<T: Decodable>(_ request: APIRequest, result: @escaping (Result<T, CustomError>) -> Void)
}

class DefaultAPIService: APIService {
    
    private let baseUrl: String
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func fetch<T>(_ request: APIRequest, result: @escaping (Result<T, CustomError>) -> Void) where T : Decodable {
        let url = URL(string: request.endPoint)!
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data else {
                result(.failure(.generalError))
                return
            }
            guard let response = response as? HTTPURLResponse, 200 ... 299  ~= response.statusCode else {
                result(.failure(.generalError))
                return
            }
            
            do {
                let dcoder = JSONDecoder()
                dcoder.keyDecodingStrategy = request.keyCodingStrategy
                let response = try dcoder.decode(T.self, from: data)
                result(.success(response))
            }
            catch {
                result(.failure(.generalError))
            }
        }.resume()
    }
}
