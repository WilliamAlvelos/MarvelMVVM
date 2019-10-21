//
//  MarvelServiceNetwork.swift
//  MarvelMVVM
//
//  Created by William Alvelos on 7/26/19.
//  Copyright © 2019 William Alvelos. All rights reserved.
//

import Foundation
import Alamofire

class MarvelServiceNetwork {
    
    private let environment: MarvelEnvironment
    
    init(environment: MarvelEnvironment) {
        self.environment = environment
    }
    
    func request<T>(url: String,
                    method: HTTPMethod = .get,
                    parameters: Parameters = [:],
                    headers: HTTPHeaders? = nil,
                    completion: @escaping (Result<T>) -> Void) {
        
        let params = MarvelParams.defaultParams.merging(parameters, uniquingKeysWith: { (_, last) in last })
        
        print(environment.url + url)
        print(method.rawValue)
        print(params)
        
        Alamofire.request(environment.url + url, method: method, parameters: params, headers: headers)
        .validate()
        .responseJSON { (response) in
            switch response.result {
            case .success:
                guard let value = response.data as? T else { return }
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
