//
//  ViewModel.swift
//  ProlificLibraryApp
//
//  Created by Bereket Ghebremedhin on 3/6/17.
//  Copyright © 2017 Bereket Ghebremedhin. All rights reserved.
//

import Foundation


final class ViewModel{
    var books:[Book] = []

    //makes request to retrieve bookArray from Prolifics API
    static func startNetworking(networkType: Networker){
        networkType.buildRequest()  
    }
    //for TVController to present on tableView Cells
     func returnBookTitle(index: IndexPath)->String{
        let bookNumber = index.row + 1
        let title = books[bookNumber].title
        return title
    }
    //for TVController to present on tableView Cells
     func returnBookAuthor(index: IndexPath)->String{
        let bookNumber = index.row + 1
        let author = books[bookNumber].author
        return author
    }
    //for DVController to present on Screen
     func returnAllDetailsOfBook(index: IndexPath)->Book{
        let bookNumber = index.row
        let book = books[bookNumber]
        return book
    }

    
    

}
