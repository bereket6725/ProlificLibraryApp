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
            let results = T.parseJSON(data: data!)
            completion(results)
        }
        task.resume()
    }
//
//    enum Network: Networkable{
//        case GETBooks(parameter: String)
//        case GETBook(parameter: String)
//        case POSTBook(parameters: [String:Any])
//        case PUTBook(parameters: [String: Any])
//        case DELETEBook(parameter: String)
//        case DELETEAllBooks(parameter: String)
//
//        static func buildRequest(networkType: Network){
//            guard let url = URL(string: baseURL) else {
//                print("problem with URL")
//                return
//            }
//            let request = NSMutableURLRequest(url: url)
//            switch networkType {
//            case .GETBooks(parameter: let allBooks):
//                request.url = URL(string: APIClient.baseURL + allBooks)
//                request.httpMethod = "GET"
//                sendRequest(request: request){ bookArray in
//                    APIClient.bookModelArray = bookArray
//                }
//            case .GETBook(parameter: let bookID):
//                request.url = URL(string: APIClient.baseURL + bookID)
//                request.httpMethod = "GET"
//                sendRequest(request: request){ bookArray in
//                    APIClient.bookModelArray = bookArray
//                }
//            case .POSTBook(parameters: let postDict):
//                let postString = postDict.map{"\($0.0)=\($0.1)" }.joined(separator: "&")
//                request.httpMethod = "POST"
//                request.httpBody = postString.data(using: String.Encoding.utf8)
//                sendRequest(request: request){ bookArray in
//                    APIClient.bookModelArray = bookArray
//                }
//            case .PUTBook(parameters: let putDict):
//                let putString = putDict.map{"\($0.0)=\($0.1)" }.joined(separator: "&")
//                request.httpMethod = "PUT"
//                request.httpBody = putString.data(using: String.Encoding.utf8)
//                sendRequest(request: request, completion: { bookArray in
//                    APIClient.bookModelArray = bookArray
//                })
//            }
//
//        }
//        static func sendRequest<T : Parsable>(request: NSMutableURLRequest, completion: @escaping (([T]) -> Void)) {
//            
//        }
//    }
}
