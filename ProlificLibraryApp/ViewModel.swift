//
//  ViewModel.swift
//  ProlificLibraryApp
//
//  Created by Bereket Ghebremedhin on 3/6/17.
//  Copyright © 2017 Bereket Ghebremedhin. All rights reserved.
//

import Foundation

fileprivate var books:[Book] = []

 struct ViewModel{
    //makes request to retrieve bookArray from Prolifics API
    static func startNetworking(request: RequestBuildable, completion: ([Book]?)->Void){
        switch request.requestType{
        case .get:
            ProlificNetworker.get(builder: request){ results in
                switch results{
                case .success(let bookArray):
                books = bookArray
                case .failure(let errorType):
                print("could not return book array due to \(errorType.localizedDescription)")
            }
            }
        default:
            ProlificNetworker.update(builder: request){ results in
                switch results {
                case .success:
                    print("updated to the server! :D")
                case .failure(let errrorType):
                    print("could not update server due to \(errrorType.localizedDescription)")
                }

            }
        }
    }
    //returns book information. It doesnt feel right to have the Controller have access to an Array of Models. Even if its just gonna present them 
    static func bookInformation(index: Int, parameter: String)->String?{
        let bookNumber = index
        switch parameter{
        case "title":
            return books[bookNumber].title
        case "author":
            return books[bookNumber].author
        case "categories":
            return books[bookNumber].categories
        case "id":
            return String(books[bookNumber].id)
        case "lastCheckedOut":
            return books[bookNumber].lastCheckedOut
        case "lastCheckedOutBy":
            return books[bookNumber].lastCheckedOutBy
        case "publisher":
            return books[bookNumber].publisher
        default:
            return nil
        }

    }

}
