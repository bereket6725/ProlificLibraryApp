//
//  CheckoutViewController.swift
//  ProlificLibraryApp
//
//  Created by Bereket Ghebremedhin on 3/10/17.
//  Copyright © 2017 Bereket Ghebremedhin. All rights reserved.
//

import UIKit
import Social

class CheckoutViewController: UIViewController {

    var bookNumber: Int = 0
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var auhorLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var checkoutInfoLabel: UILabel!
    @IBOutlet weak var checkoutButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var checkOutByInfoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.checkoutButton.layer.cornerRadius = 20.0
        self.shareButton.layer.cornerRadius = 20.0

        self.titleLabel.text = ViewModel.bookInfo(bookNumber: bookNumber, param: "title")
        self.auhorLabel.text = ViewModel.bookInfo(bookNumber: bookNumber, param: "author")
        self.categoriesLabel.text = ViewModel.bookInfo(bookNumber: bookNumber, param: "categories")
        self.checkoutInfoLabel.text = ViewModel.bookInfo(bookNumber: bookNumber, param: "lastCheckedOut") ?? "not checked out"
        self.checkOutByInfoLabel.text = ViewModel.bookInfo(bookNumber: bookNumber, param: "lastCheckedOutBy") ?? "not checked out by anyone yet"
    }

    @IBAction func checkoutButtonTapped(_ sender: Any) {
        let bookID = ViewModel.BookIDForIndex(index: bookNumber)
        let checkOutData = ["lastCheckedOutBy": "Bereket"]
        let params = checkOutData as [String: Any]
        let putRequest = ProlificRequest(type: .put(id: bookID, parameters: params))
        ViewModel.startUpdating(request: putRequest){results in
            switch results{
            case .success():
                print("updated Book!")
            case .failure(let errorType):
                print("could not update book due to \(errorType.localizedDescription)")
            }
        }
    }

    @IBAction func shareButtonTapped(_ sender: Any) {
        if  let bookTitle = ViewModel.bookInfo(bookNumber: bookNumber, param: "title"){
            if let bookAuthor = ViewModel.bookInfo(bookNumber: bookNumber, param: "author"){
                if let vc = SLComposeViewController(forServiceType: SLServiceTypeFacebook) {
                    vc.setInitialText("Everyone should check out \(bookTitle) by \(bookAuthor)")
                    present(vc, animated: true)
                }
            }
        }
}
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
