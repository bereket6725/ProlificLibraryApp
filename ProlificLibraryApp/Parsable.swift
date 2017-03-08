//
//  Parsable.swift
//  ProlificLibraryApp
//
//  Created by Bereket Ghebremedhin on 3/6/17.
//  Copyright © 2017 Bereket Ghebremedhin. All rights reserved.
//

import Foundation

protocol Parsable{
    associatedType T
    static func parseJSON(data: Data) -> T 
}
