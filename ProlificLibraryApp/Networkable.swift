//
//  Networkable.swift
//  ProlificLibraryApp
//
//  Created by Bereket Ghebremedhin on 3/7/17.
//  Copyright © 2017 Bereket Ghebremedhin. All rights reserved.
//

import Foundation
import Alamofire

protocol Networkable{
    static func request<T:Parsable>(API: API, method: HTTPMethod, parameters: [String:AnyObject]?, completion: @escaping ([T]?, DataRequest?, Error?)->Void)

}
