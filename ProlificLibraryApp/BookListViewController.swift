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
        view.addSubview(tableView)
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.rowHeight = 60.0
        tableView.register(UINib(nibName:"BookTableViewCell", bundle: nil), forCellReuseIdentifier: "CellIdentifier")
        getBooks()
        //postBooks()
        
    }

//    func postBooks(){
//        let bookData = ["author": "testAuthor7", "categories": "testCategories7", "title":"titleTest7", "publisher":"testPublisher7"]
//        let params = bookData as [String: Any]
//        let postRequest = ProlificRequest(type: .post(parameters: params))
//        ViewModel.startUpdating(request: postRequest){results in
//            switch results{
//            case .success():
//                print("updated!")
//            case .failure(let error):
//                print("couldnt update due to \(error.localizedDescription)")
//            }
//       }
//    }

    func getBooks(){
        let getRequest = ProlificRequest(type: .get)
        ViewModel.requestBooks(request: getRequest){bookArray in
            if bookArray != nil {
            self.dataSource.bookArray = bookArray!
            self.tableView.reloadData()
            }
            else{
                print("couldnt get books")
            }
        }
    }

    @IBAction func AddBookButtonTapped(_ sender: Any) {

    }


    @IBAction func deleteAllBooksButtonTapped(_ sender: Any) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "BookDetail") as? CheckoutViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    func reloadTableData(){
        getBooks()
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
