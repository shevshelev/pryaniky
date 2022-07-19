//
//  NetworkManager.swift
//  pryaniky
//
//  Created by Shevshelev Lev on 18.07.2022.
//

import Alamofire

protocol NetworkManagerProtocol: AnyObject {
    func fetchData(_ completion: @escaping (Result<Response, AFError>) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    static let shared: NetworkManagerProtocol = NetworkManager()
    private let urlString = "https://pryaniky.com/static/json/sample.json"
    
    private init() {}
    
    func fetchData(_ completion: @escaping (Result<Response, AFError>) -> Void) {
        AF.request(urlString)
            .validate()
            .responseDecodable(of: Response.self) { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    
}

