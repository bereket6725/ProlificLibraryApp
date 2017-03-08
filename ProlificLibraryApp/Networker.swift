//
//  Networker.swift
//  ProlificLibraryApp
//
//  Created by Bereket Ghebremedhin on 3/7/17.
//  Copyright © 2017 Bereket Ghebremedhin. All rights reserved.
//

import Foundation
import Alamofire
//handles request errors
enum RequestError{
    case invalidUrl
    case invalidData
    case defaultRequestError
}
//this file will execute our network request 
extension Networkable  {
    func requestData(builder: RequestBuildable,
                     completion: @escaping (Result<Data, RequestError>) -> Void) {
        guard let url = builder.endpoint else { completion(.failure(.invalidUrl)); return }
        let type = builder.requestType

        switch type {
        case .get:
            Alamofire.request(url).responseJSON{ response in
                guard let rawData = response.data else { completion(.failure(.invalidData)); return }
                completion(.success(rawData))
            }
        default: fatalError("invalid request type: \(type). Expected: .get")
        }
    }

    func requestUpdate(builder: RequestBuildable, completion: @escaping (Result<Void, RequestError>) -> Void) {

        guard let url = builder.endpoint else { completion(.failure(.invalidUrl)); return }
        var updateParameters: [String: Any]?

        switch builder.requestType {
        case .get: fatalError("invalid request type. .get is not for updates")
        case .put(_ , let parameters): updateParameters = parameters
        case .post(_ , let parameters): updateParameters = parameters
        default: updateParameters = nil
        }
        Alamofire.request(url, method: builder.requestType.methodType, parameters: updateParameters).responseJSON{  response in
            if let statusCode = response.response?.statusCode, 200..<300 ~= statusCode {
                completion(.success(()))
            } else {
                completion(.failure(.defaultRequestError))
            }
        }
    }
}

//makes request
struct ProlificNetworker: Networkable {
    func get(builder: RequestBuildable, completion: @escaping (Result<[Book], RequestError>) -> Void) {
        requestData(builder: builder) { result in
            switch result {
            case .success(let data): completion(.success(Book.parseJSON(data: data)))
            case .failure(let error): completion(.failure(error))
            }
        }
    }

    func update(builder: RequestBuildable, completion: @escaping (Result<Void, RequestError>) -> Void){
        requestUpdate(builder: builder) { result in
            switch result {
            case .success: completion(.success())
            case .failure(let error): completion(.failure(error))
            }
        }
    }
}

