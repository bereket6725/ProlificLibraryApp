//
//  Networker.swift
//  ProlificLibraryApp
//
//  Created by Bereket Ghebremedhin on 3/7/17.
//  Copyright © 2017 Bereket Ghebremedhin. All rights reserved.
//

import Foundation
import Alamofire

enum RequestError{
    case invalidUrl
    case invalidData
    case defaultRequestError
}

//file will execute our Network Request 
struct Networker{

    static func request<T: Parsable>(url: URL, method: HTTPMethod,  parameters: [String:AnyObject]?,completion: @escaping ([T]?, DataRequest?, Error?)->Void) {
        switch method{
        case .get:
            Alamofire.request(url).responseData{ data in
                guard let rawData = data.data else { return }
                let results = T.parseJSON(data: rawData)
                completion(results, nil, nil)
            }
        case .post:
            let dataRequest = Alamofire.request(url, method: .post, parameters: parameters)
            completion(nil, dataRequest, nil)
        case .put:
            let dataRequest = Alamofire.request(url, method: .put, parameters: parameters)
            completion(nil, dataRequest, nil)
        case .delete:
            let dataRequest = Alamofire.request(url, method: .delete, parameters: parameters)
            completion(nil, dataRequest, nil)
        default:
            print("wrong HTTPMethod")
        }

    }
}
