//
//  BookListViewController.swift
//  ProlificLibraryApp
//
//  Created by Bereket Ghebremedhin on 3/6/17.
//  Copyright © 2017 Bereket Ghebremedhin. All rights reserved.
//

import UIKit

class BookListViewController: UIViewController, UITableViewDelegate{
    var tableView: UITableView!
    var dataSource: TableDataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: view.bounds)
        dataSource = TableDataSource()
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.rowHeight = 65.0
        view.addSubview(tableView)
        tableView.register(UINib(nibName:"TableViewCell", bundle: nil), forCellReuseIdentifier: "CellIdentifier")
//        getBooks()
//        let postRequest = ProlificRequest(type: .post(parameters: bookData))
//        ViewModel.startNetworking(request: postRequest){results in
//            print("results")
//
//        }

    }

    func getBooks(){
        let getRequest = ProlificRequest(type: .get)
        ViewModel.startNetworking(request: getRequest){results in
            print("\(results)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

    func reloadTableData(){
        getBooks()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
