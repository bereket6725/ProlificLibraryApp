//
//  URLRequestBuilder.swift
//  ProlificLibraryApp
//
//  Created by Bereket Ghebremedhin on 3/4/17.
//  Copyright © 2017 Bereket Ghebremedhin. All rights reserved.
//

import Foundation


struct URLRequestBuilder{
    static let PLbaseURL =  "http://prolific-interview.herokuapp.com/58b0a27680b91a000a49ef17/"
    static var bookModelArray: [BookModel] = []

    enum Network{
        case GETBooks(parameter: String)
        case GETBook(parameter: String)
        case POSTBook(parameters: [String:Any])
        case PUTBook(parameters: [String: Any])
        case DELETEBook(parameter: String)
        case DELETEAllBooks(parameter: String)

        static func buildRequest(networkType: Network){
            guard let url = URL(string: PLbaseURL) else {
                print("problem with URL")
                return
            }
            let request = NSMutableURLRequest(url: url)
            switch networkType {
            case .GETBooks(parameter: let allBooks):
                request.url = URL(string: URLRequestBuilder.PLbaseURL + allBooks)
                request.httpMethod = "GET"
                APIClient.sendRequest(request: request){ bookArray in
                    DispatchQueue.main.async{
                    APIClient.bookModelArray = bookArray
                    }
                }
            case .GETBook(parameter: let bookID):
                request.url = URL(string: URLRequestBuilder.PLbaseURL + bookID)
                request.httpMethod = "GET"
                APIClient.sendRequest(request: request){ bookArray in
                    DispatchQueue.main.async{
                    APIClient.bookModelArray = bookArray
                    }
                }
            case .POSTBook(parameters: let postDict):
                let postString = postDict.map{"\($0.0)=\($0.1)" }.joined(separator: "&")
                request.httpMethod = "POST"
                request.httpBody = postString.data(using: String.Encoding.utf8)
                APIClient.sendRequest(request: request){ bookArray in
                    DispatchQueue.main.async{
                        APIClient.bookModelArray = bookArray
                    }
                    //print("alright then")
                }
            case .PUTBook(parameters: let putDict):
                let putString = putDict.map{"\($0.0)=\($0.1)" }.joined(separator: "&")
                request.httpMethod = "PUT"
                request.httpBody = putString.data(using: String.Encoding.utf8)
                APIClient.sendRequest(request: request) { bookArray in
                    DispatchQueue.main.async{
                        APIClient.bookModelArray = bookArray
                    }
                }
            case .DELETEBook(parameter: let deletedBookID):
                request.url = URL(string: URLRequestBuilder.PLbaseURL + deletedBookID)
                request.httpMethod = "DELETE"
                APIClient.sendRequest(request: request) { bookArray in
                    DispatchQueue.main.async{
                        APIClient.bookModelArray = bookArray
                    }
                }
            case .DELETEAllBooks(parameter: let deleteAllID):
                request.url = URL(string: URLRequestBuilder.PLbaseURL + deleteAllID)
                request.httpMethod = "DELETE"
                APIClient.sendRequest(request: request){ bookArray in
                    DispatchQueue.main.async{
                        APIClient.bookModelArray = bookArray
                    }
                }
            }
            
        }


    }
}
