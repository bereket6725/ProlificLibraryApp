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
    let lastCheckedOut: String
    let lastCheckedOutBy: String
    let publisher: String
    let title : String
    let url: String

    static func parseJSON(data: Data) -> [BookModel] {
        return [BookModel]()
    }
}
