//
//  NetworkType.swift
//  ProlificLibraryApp
//
//  Created by Bereket Ghebremedhin on 3/7/17.
//  Copyright © 2017 Bereket Ghebremedhin. All rights reserved.
//

import Foundation
import Alamofire

//handle errors from our API
enum Result <T, E:Error>{
    case success(T)
    case failure(E)
}

protocol RequestBuildable {
    var requestType: RequestType { get }
    var endpoint: URL? { get }
}

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
        case .post(let id, _): endpoint = URL(string: BaseUrlStrings.prolific + ProlificAPIParameter.books + "/\(id)")
        case .delete(let id): endpoint = URL(string: BaseUrlStrings.prolific + ProlificAPIParameter.books + "/\(id)")

        }
        self.endpoint = endpoint
    }
}

//this file will build out network request
struct BaseUrlStrings{
    fileprivate static let prolificUrlString = "http:prolific-interview.herokuapp.com/58b0a27680b91a000a49ef17/"
}

struct ProlificAPIParameter{
    static let books  = "books"
    static let clearBooks = "clear"
}

//decides what API we use and gets us the right URL
//now, it might seem overkill when we just have one case, but Im trying to imagine how this app looks like in the future.
//I would suspect then that we might end up using a variety of API's so this design may come in handy as it grows
enum API{
    case Prolific

    func apiBaseUrl(queryParameters: String?)->URL?{
        switch self{
        case .Prolific:
            guard queryParameters != nil else {return URL(string: BaseUrls.prolificUrlString)}
            return URL(string: BaseUrls.prolificUrlString+queryParameters!)
        }
    }
}


//determines the type of the request 
enum RequestType {
    case get
    case post(id: Int, parameters: [String: Any])
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


