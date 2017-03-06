//
//  Networker.swift
//  ProlificLibraryApp
//
//  Created by Bereket Ghebremedhin on 3/6/17.
//  Copyright © 2017 Bereket Ghebremedhin. All rights reserved.
//

import Foundation
import Alamofire

enum Networker: NetworkingProtocol {
    case GET
    case POST
    case PUT
    case DELETE(int: Int, all: Bool)

    
    func requestType(){
        switch self{
        case .GET:
            print("GET request")
        case .POST:
            print("POST request")
        case .PUT:
            print("PUT request")
        case .DELETE(let id, let all):
            print("DELETE \(id) or \(all)")

        }
    }


    static func buildURL()->URL{
        return URL(string:"www.google.com")!
    }

    static func makeRequest(){
    }

}
