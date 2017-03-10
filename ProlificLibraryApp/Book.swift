//
//  Book.swift
//  ProlificLibraryApp
//
//  Created by Bereket Ghebremedhin on 3/6/17.
//  Copyright © 2017 Bereket Ghebremedhin. All rights reserved.
//

import Foundation

struct Book: Parsable{
    let author : String
    let categories: String
    let id: Int
    let lastCheckedOut: String?
    let lastCheckedOutBy: String?
    let publisher: String?
    let title : String
    let url: String

    typealias JSONStandard = [[String:AnyObject]]

    static func parseJSON(data: Data) -> [Book] {
        var bookArray: [Book] = []
        if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! JSONStandard{
            // print("\(json)")
            for book in json {
                let book = Book.init(author: book["author"] as! String, categories: book["categories"] as! String , id: book["id"] as! Int, lastCheckedOut: book["lastCheckedOut"] as? String, lastCheckedOutBy: book["lastCheckedOutBy"] as? String, publisher: book["publisher"] as? String, title: book["title"] as! String, url: book["url"] as! String)
                print("book \(book.id) is \(book)\n")
                bookArray.append(book)

            }
        }

        return bookArray
    }
}
