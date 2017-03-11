//
//  ViewModel.swift
//  ProlificLibraryApp
//
//  Created by Bereket Ghebremedhin on 3/6/17.
//  Copyright © 2017 Bereket Ghebremedhin. All rights reserved.
//

import Foundation
import Alamofire

fileprivate var books:[Book] = []

class ViewModel{
    //makes request to retrieve bookArray from Prolifics API
    static func requestBooks(request: RequestBuildable,
                                completion: @escaping ([Book]?) -> Void) {
        switch request.requestType{
        case .get:
            ProlificNetworker.get(builder: request){ results in
                switch results{
                case .success(let booksArray):
                    books = booksArray
                    print("these are our books \(books)\n")
                    completion(booksArray)

                case .failure(let errorType):
                    print("Could not retrieve book array, due to \(errorType.localizedDescription)")
                    completion(nil)
                }
            }
        default:
            print("bad request Type. Only GET requests!")
        }
    }


    static func startUpdating(request: RequestBuildable, completion: @escaping (Result<Void, RequestError>) -> Void){
        switch request.requestType{
        case .post, .put, .delete, .clear:
            ProlificNetworker.update(builder: request){ results in
                switch results{
                case .success():
                let request = ProlificRequest(type: .get)
                ViewModel.requestBooks(request: request){ updatedBooks in
                completion(.success())
                }
                case .failure(let error):
                completion(.failure(error))
                }
            }
        default:
            print("bad request")
    }
}
    static func BookIDForIndex(index: Int)->Int{
        let id = books[index].id
        return id
    }
    
    static func bookInfo(bookNumber: Int, param: String)->String?{
        switch param{
            case "title":
                return books[bookNumber].title
            case "author":
                return books[bookNumber].author
            case "publisher":
                return books[bookNumber].publisher
            case "categories":
                return books[bookNumber].categories
            case "lastCheckedOut":
                return books[bookNumber].lastCheckedOut
            case "lastCheckedOutBy":
                return books[bookNumber].lastCheckedOutBy
            default:
            print("wrong parameter")
            return " "
        }
    }
}
