//
//  Book.swift
//  ProlificLibraryApp
//
//  Created by Bereket Ghebremedhin on 3/6/17.
//  Copyright © 2017 Bereket Ghebremedhin. All rights reserved.
//

import Foundation

struct Book: Parsable{
    let author: String
    let categories: String
    let id: Int
    let lastCheckedOut: String?
    let lastCheckedOutBy: String?
    let publisher: String
    let title : String

    typealias JSONStandard = [[String:AnyObject]]

    init?(bookData: [String: Any]) {

        guard let author = bookData["author"] as? String,
            let categories = bookData["categories"] as? String,
            let title = bookData["title"] as? String,
            let publisher = bookData["publisher"] as? String,
            let id = bookData["id"] as? Int else { return nil }

        self.author = author
        self.categories = categories
        self.title = title
        self.publisher = publisher
        self.id = id

        self.lastCheckedOut = bookData["lastCheckedOut"] as? String
        self.lastCheckedOutBy = bookData["lastCheckedOutBy"] as? String
    }

    static func parseJSON(data: Data) -> [Book] {
        if let json = (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)) as? JSONStandard {
            var bookJson = [[String: Any]]()
            for entry in json {
                let validTuples = entry.filter { !($0.1 is NSNull) }
                var validBookData = [String: Any]()
                for tuple in validTuples {
                    validBookData[tuple.key] = tuple.value
                }

                bookJson.append(validBookData)
            }
            return bookJson.flatMap { Book(bookData: $0) }
        }

        return []
    }
}
