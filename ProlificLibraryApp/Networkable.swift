//
//  Networkable.swift
//  ProlificLibraryApp
//
//  Created by Bereket Ghebremedhin on 3/7/17.
//  Copyright © 2017 Bereket Ghebremedhin. All rights reserved.
//

import Foundation
import Alamofire

protocol Networkable {
    associatedtype P: Parsable
    static func get(builder: RequestBuildable, completion: @escaping (Result<[P], RequestError>) -> Void)
    static func update(builder: RequestBuildable, completion: @escaping (Result<Void, RequestError>) -> Void)
}

extension Networkable {

    static func requestData(builder: RequestBuildable,
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

    static func requestUpdate(builder: RequestBuildable, completion: @escaping (Result<Void, RequestError>) -> Void) {

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
