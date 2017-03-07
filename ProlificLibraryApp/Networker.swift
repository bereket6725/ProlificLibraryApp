//
//  Networker.swift
//  ProlificLibraryApp
//
//  Created by Bereket Ghebremedhin on 3/6/17.
//  Copyright © 2017 Bereket Ghebremedhin. All rights reserved.
//

import Foundation
import Alamofire



enum Networker:NetworkingProtocol {
    case GET(String)
    case POST([String:AnyObject])
    case PUT([String:AnyObject])
    case DELETE(id: Int?)

    func getRequest(baseURL: String, books: String, completion: @escaping ([Book])->Void){
        Alamofire.request(baseURL+books).responseData{ data in
            guard let rawData = data.data else{
                print("data error")
                return
            }
            let results = Book.parseJSON(data: rawData)
            completion(results)
        }
    }

    func buildRequest(){
        let baseURL = "http://prolific-interview.herokuapp.com/58b0a27680b91a000a49ef17/"

        switch self{
        case .GET(let books):
            getRequest(baseURL: baseURL, books: books) { _ in

            }
        case .POST(let postDictionary):
            _ = Alamofire.request(baseURL, method: .post, parameters: postDictionary)
        case .PUT(let putDictionary):
            _ = Alamofire.request(baseURL, method: .put, parameters: putDictionary)
        case .DELETE(let id):
            if id == nil {
                _ =  Alamofire.request(baseURL+"clean", method: .delete)
            }
            else{
                let stringID = String(id!)
                _ = Alamofire.request(baseURL+stringID, method: .delete)
                
            }
        }
    }
}
