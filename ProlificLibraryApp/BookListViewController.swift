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
        let myRefreshControl = UIRefreshControl()
        myRefreshControl.backgroundColor = UIColor.gray
        myRefreshControl.tintColor = UIColor.white
        myRefreshControl.addTarget(self, action: #selector(BookListViewController.getBooks), for: .valueChanged)
        self.tableView.refreshControl = myRefreshControl
        getBooks()
        //postBooks()
    }

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        getBooks()
//    }

    func getBooks(){
        let getRequest = ProlificRequest(type: .get)
        ViewModel.requestBooks(request: getRequest){bookArray in
            if bookArray != nil {
            self.dataSource.bookArray = bookArray!
            self.reloadTableView()
            }
            else{
                print("couldnt get books")
            }
        }
    }

    func reloadTableView(){
        self.tableView.reloadData()
        self.tableView.refreshControl?.endRefreshing()
    }

    @IBAction func AddBookButtonTapped(_ sender: Any) {

    }

    @IBAction func deleteAllBooksButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "You Sure?", message: "This will delete all books. Do you wish to proceed?", preferredStyle: .alert)

        let deleteAll = UIAlertAction(title: "Continue", style: .default){ action in
           let clearRequest = ProlificRequest(type: .clear)
           self.startUpdating(request: clearRequest)
        }
        
        let cancel = UIAlertAction(title: "cancel", style: .cancel, handler: nil)

        //alert.addAction(UIAlertAction(title: "Delete All", style: .default, handler: self.startUpdating))
        alert.addAction(deleteAll)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
        
    }

    func startUpdating(request: ProlificRequest){        
        ViewModel.startUpdating(request: request){results in
            switch results{
            case .success():
                self.tableView.reloadData()
                
                print("success!")
                self.tableView.reloadData()
            case .failure(let errorType):
                print("could not perform operation due to \(errorType.localizedDescription)")
            }

        }
    }
    
    func alert(){

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "BookDetail") as? CheckoutViewController {
            vc.bookNumber = indexPath.row
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    func reloadTableData(){
        getBooks()
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

}
}
