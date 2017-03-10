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
enum RequestError:Error{
    case invalidUrl
    case invalidData
    case defaultRequestError
}
//Object that handles Pqrolific API Networking
struct ProlificNetworker: Networkable {
    static func get(builder: RequestBuildable, completion: @escaping (Result<[Book], RequestError>) -> Void) {
        requestData(builder: builder) { result in
            switch result {
            case .success(let data): completion(.success(Book.parseJSON(data: data)))
            case .failure(let error): completion(.failure(error))
            }
        }
    }

    static func update(builder: RequestBuildable, completion: @escaping (Result<Void, RequestError>) -> Void){
        requestUpdate(builder: builder) { result in
            switch result {
            case .success: completion(.success())
            case .failure(let error): completion(.failure(error))
            }
        }
    }
}

