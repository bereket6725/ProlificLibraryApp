//
//  APIClient.swift
//  ProlificLibraryApp
//
//  Created by Bereket Ghebremedhin on 3/4/17.
//  Copyright © 2017 Bereket Ghebremedhin. All rights reserved.
//

import Foundation

protocol Networkable{
    static func sendRequest<T: Parsable>(request: NSMutableURLRequest, completion: @escaping (([T])-> Void))
}
struct APIClient:Networkable {

    static let baseURL =  "http://prolific-interview.herokuapp.com/58b0a27680b91a000a49ef17/"
    static var bookModelArray: [BookModel] = []

    static func sendRequest<T : Parsable>(request: NSMutableURLRequest, completion: @escaping (([T]) -> Void)) {
        let task = URLSession.shared.dataTask(with: request as URLRequest){ (data, response, error) in
            guard data != nil else{
                print("\(error?.localizedDescription)")
                return
            }
            print("\(data)")
            //let results = T.parseJSON(data: data!)
            //completion(results)
        }
        task.resume()
    }
}


