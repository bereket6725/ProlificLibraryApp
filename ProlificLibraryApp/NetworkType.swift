//
//  NetworkType.swift
//  ProlificLibraryApp
//
//  Created by Bereket Ghebremedhin on 3/7/17.
//  Copyright © 2017 Bereket Ghebremedhin. All rights reserved.
//

import Foundation
import Alamofire

enum Result <T, E:Error>{
    case success(T)
    case failure(E)
}

//holds all our information needed to pass in our Networker (particularly our Prolific Netowkrer)
struct ProlificRequest: RequestBuildable {
    let requestType: RequestType
    let endpoint: URL?

    init(type: RequestType) {
        self.requestType = type

        var endpoint: URL?

        switch type {
        case .get: endpoint = URL(string: BaseUrlStrings.prolific + ProlificAPIParameter.books)
        case .clear: endpoint = URL(string: BaseUrlStrings.prolific + ProlificAPIParameter.deleteAll)
        case .put(let id, _): endpoint = URL(string: BaseUrlStrings.prolific + ProlificAPIParameter.books + "/\(id)")
        case .post(_): endpoint = URL(string: BaseUrlStrings.prolific + ProlificAPIParameter.books)
        case .delete(let id): endpoint = URL(string: BaseUrlStrings.prolific + ProlificAPIParameter.books + "/\(id)")

        }
        self.endpoint = endpoint
    }
}


struct BaseUrlStrings {
    fileprivate static let prolific = "http:prolific-interview.herokuapp.com/58b0a27680b91a000a49ef17"
}

struct ProlificAPIParameter{
    static let books  =  "/books"
    static let deleteAll  =  "/clear"
}

//determines the request type
enum RequestType {
    case get
    case post(parameters: [String: Any])
    case put(id: Int, parameters: [String: Any])
    case delete(id: Int)
    case clear(String)

    var methodType: Alamofire.HTTPMethod {
        switch self{
        case .get:
            return .get
        case .put:
            return .put
        case .post:
            return .post
        case .delete, .clear:
            return .delete
        }
    }
}

