//
//  ViewModel.swift
//  ProlificLibraryApp
//
//  Created by Bereket Ghebremedhin on 3/6/17.
//  Copyright © 2017 Bereket Ghebremedhin. All rights reserved.
//

import Foundation
import Alamofire

var books:[Book] = []

class ViewModel{
    //makes request to retrieve bookArray from Prolifics API

    static func startNetworking(request: RequestBuildable,
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
            ProlificNetworker.update(builder: request){results in
                switch results{
                case .success():
                    print("updated the server!")
                case .failure(let errorType):
                    print("could not update server due to \(errorType.localizedDescription)")
                }
            }
        }

    }

    //returns the preview information we use in the tableViewCell because
    //something felt off to me about the Controller holding the model, even if its just to present it.
    static func bookInformation(index: Int, parameter: String)->String?{
        let bookNumber = index
        switch parameter{
        case "title":
            let title = books[bookNumber].title
            return title
        case "author":
            let author = books[bookNumber].author
            return author
        case "categories":
            let categories = books[bookNumber].categories
            return categories
        case "id":
            let id = String(books[bookNumber].id)
            return id
        case "lastCheckedOut":
            let lastCheckedOut = books[bookNumber].lastCheckedOut
            return lastCheckedOut
        case "lastCheckedOutBy":
            let lastCheckedOutBy = books[bookNumber].lastCheckedOutBy
            return lastCheckedOutBy
        case "publisher":
            let publisher = books[bookNumber].publisher
            return publisher
        default:
            return nil
        }
    }
    static func ArrayModelLength()->Int{
        return books.count
    }
}
