//
//  ViewModel.swift
//  ProlificLibraryApp
//
//  Created by Bereket Ghebremedhin on 3/6/17.
//  Copyright © 2017 Bereket Ghebremedhin. All rights reserved.
//

import Foundation


 struct ViewModel{
    private var books:[Book] = []

    //makes request to retrieve bookArray from Prolifics API
    func startNetworking(networkType: Networker){
//        networkType.buildRequest(requestType: .GET){ returnObject in
//            if let booksArray = returnObject as! [Book]{
//                self.books = booksArray
//            }
//            else if let dataRequest = returnObject as! DataRequest{
//                print(dataRequest)
//            }
//            else{
//                print("error")
//            }
//
//        }
        networkType.buildRequest(requestType: .GET){results in
            print("\(results)")
        }
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
