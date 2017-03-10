//
//  TableDataSource.swift
//  ProlificLibraryApp
//
//  Created by Bereket Ghebremedhin on 3/6/17.
//  Copyright © 2017 Bereket Ghebremedhin. All rights reserved.
//

import UIKit

class TableDataSource:NSObject, UITableViewDataSource {

    var  bookArray :[Book] = []

    //MARK: TableViewDataSource Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bookArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier") as! BookTableViewCell
        cell.bookTitleLabel?.text = bookArray[indexPath.row].title
        cell.bookAuthorLabel?.text = bookArray[indexPath.row].author
        
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {

        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            let bookID = bookArray[indexPath.row].id
            let deleteRequest = ProlificRequest(type: .delete(id: bookID))
            ViewModel.startNetworking(request: deleteRequest){_ in 
                self.bookArray.remove(at: indexPath.row)
                print("dsd \(self.bookArray)")
                tableView.reloadData()
            }
            
        }
    }
}
