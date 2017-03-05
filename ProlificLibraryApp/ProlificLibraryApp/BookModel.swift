//
//  BookModel.swift
//  ProlificLibraryApp
//
//  Created by Bereket Ghebremedhin on 3/4/17.
//  Copyright © 2017 Bereket Ghebremedhin. All rights reserved.
//

import Foundation


struct BookModel: Parsable{
    let author : String
    let categories: String
    let id: Int
    let lastCheckedOut: String?
    let lastCheckedOutBy: String?
    let publisher: String?
    let title : String
    let url: String

    typealias JSONStandard = [[String:AnyObject]]

    static func parseJSON(data: Data) -> [BookModel] {
        var bookArray: [BookModel] = []
            if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! JSONStandard{
               // print("\(json)")
                for bookModel in json {
                    let bookModel = BookModel(author: bookModel["author"] as! String, categories: bookModel["categories"] as! String , id: bookModel["id"] as! Int, lastCheckedOut: bookModel["lastCheckedOut"] as? String, lastCheckedOutBy: bookModel["lastCheckedOutBy"] as? String, publisher: bookModel["publisher"] as? String, title: bookModel["title"] as! String, url: bookModel["url"] as! String)
                    bookArray.append(bookModel)
                    
                }
                }
        
        return bookArray
}
}
