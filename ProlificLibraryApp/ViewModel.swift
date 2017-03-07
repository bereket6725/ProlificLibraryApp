//
//  ViewModel.swift
//  ProlificLibraryApp
//
//  Created by Bereket Ghebremedhin on 3/6/17.
//  Copyright © 2017 Bereket Ghebremedhin. All rights reserved.
//

import Foundation


final class ViewModel{
    private var books: [Book] = []

    //makes request to retrieve bookArray from Prolifics API
    static func startNetworking(networkType: Networker){
        n
    }
    //for TVController to present on tableView Cells
    static func returnBookTitle(index: IndexPath)->String{
        return "test"
    }
    //for TVController to present on tableView Cells
    static func returnBookAuthor(index: IndexPath)->String{
        return "test"
    }
    //for DVController to present on Screen
    static func returnAllBookDetails(index: IndexPath)->Book{
        return Book(author: "author-Test", categories: "categories-Test", id: 000, lastCheckedOut: "lastCheckedOut-Test", lastCheckedOutBy: "lastCheckedOutBy-Test", publisher: "publisher-Test", title: "title-Test", url: "url-Test")
    }

    
    

}
