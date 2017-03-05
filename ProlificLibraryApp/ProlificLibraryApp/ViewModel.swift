//
//  ViewModel.swift
//  ProlificLibraryApp
//
//  Created by Bereket Ghebremedhin on 3/4/17.
//  Copyright © 2017 Bereket Ghebremedhin. All rights reserved.
//

import Foundation


 struct ViewModel{

    var bookModelArray: [BookModel] = []

    static let sampleDictionary = ["author": "J.K. Rowling", "categories":"fantasy", "title": "Harry Potter and the Goblet of Fire","publisher":"Random House"] as [String:Any]


    static func startNetworking(){
        URLRequestBuilder.Network.buildRequest(networkType: .GETBook(parameter: "books"))
    }
    
    

}
