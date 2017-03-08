//
//  NetworkType.swift
//  ProlificLibraryApp
//
//  Created by Bereket Ghebremedhin on 3/7/17.
//  Copyright © 2017 Bereket Ghebremedhin. All rights reserved.
//

import Foundation
import Alamofire

//this file will build out network request
struct BaseUrls{
    fileprivate static let prolificUrlString = "http:prolific-interview.herokuapp.com/58b0a27680b91a000a49ef17/"
}

struct ProlificAPIParameters{
    static let getBooks  = "books"
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
enum RequestType{
    case get(String)
    case post([String:AnyObject])
    case put([String:AnyObject])
    case delete(id: Int)
    case clear(String)

    var methodType: Alamofire.HTTPMethod{
        switch self{
        case .get:
            return .get
        case .post:
            return .post
        case .put:
            return .put
        case .delete, .clear: //both are delete requests
            return .delete
        }
    }
}


